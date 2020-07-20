#!/bin/bash

clear

cover_in_de="coverletter_de"
cover_out_de="output/JingXu_Anschreiben_2020.pdf"

resume_in_de="resume_de"
resume_out_de="output/JingXu_Lebenslauf_2020.pdf"

cover_in_en="coverletter_en"
cover_out_en="output/JingXu_Motivation_2020.pdf"

resume_in_en="resume_en"
resume_out_en="output/JingXu_CV_2020.pdf"

coverCmd_de=
coverCmd_en=
resumeCmd=

function getInfo(){
    # clear
    coverCmd_de=""
    coverCmd_en=""
    resumeCmd=""

    local cmd=""

    echo "=== Please tell me the name of you applicated Job:"
    read job_name
    echo ""

    echo "=== Please tell me the information of your applicated Company:"
    read -p "Recipient: " recname
    read -p "Name: " comname
    read -p "Address: " addr
    read -p "Postcode, location: " loc
    echo ""

    echo "=== Please Choose the following options to tell me the Recipient:"
    echo -e "\t1. Dear Sir or Madam,"
    echo -e "\t2. Dear Mr. Family Name," 
    echo -e "\t3. Dear Ms. Family Name,"
    read -p "Input your choice nummber: " num

    local letterbegin_de="Sehr geehrte Damen und Herren,"
    local letterbegin_en="Dear Sir or Madam,"
    if [ $num -eq 2 ]
    then
        read -p "Tell me the name: " hrname
        letterbegin_de="Sehr geehrter Herr $hrname,"
        letterbegin_en="Dear Mr. $hrname,"
    elif [ $num -eq 3 ]
    then
        read -p "Tell me the name: " hrname
        letterbegin_de="Sehr geehrte Frau $hrname,"
        letterbegin_en="Dear Ms. $hrname"
    fi

    echo ""

    if [ -n "$job_name" ]
    then
        cmd="\newcommand{\applicatename}{${job_name}} ${cmd}"
        resumeCmd="\newcommand{\applicatename}{${job_name}}"
    fi

    if [ -n "$recname" ]
    then
    cmd="\newcommand{\recname}{${recname}} ${cmd}"
    fi

    if [ -n "$comname" ] # 必须两边空格
    then
    cmd="\newcommand{\companyname}{${comname}} ${cmd}" #赋值必须紧贴等号
    fi

    if [ -n "$addr" ] 
    then
    cmd="\newcommand{\companyaddress}{${addr}} ${cmd}"
    fi

    if [ -n "$loc" ]
    then 
    cmd="\newcommand{\companylocal}{${loc}} ${cmd}"
    fi

    coverCmd_de="\newcommand{\letterbegin}{${letterbegin_de}} ${cmd}"
    coverCmd_en="\newcommand{\letterbegin}{${letterbegin_en}} ${cmd}"
}

function check(){
    getInfo
    echo "=== Please check your inputs!"
    read -p "If wrong, input 1. If right, input any key: " flag
    echo ""

    if [ $flag -eq 1 ]
    then
        check
    fi
}

function compile(){
    coverCmd_de="${coverCmd_de} \input{${cover_in_de}}"
    coverCmd_en="${coverCmd_en} \input{${cover_in_en}}"
    local resumeCmd_de="${resumeCmd} \input{${resume_in_de}}"
    local resumeCmd_en="${resumeCmd} \input{${resume_in_en}}"

    if [ $1 -eq 1 ]     # create english resume and cover letter
    then 
        lualatex -synctex=1 -interaction=nonstopmode $resumeCmd_en
        mv "${resume_in_en}.pdf" $resume_out_en
        lualatex -synctex=1 -interaction=nonstopmode $coverCmd_en
        mv "${cover_in_en}.pdf" $cover_out_en
    elif [ $1 -eq 2 ]   # create german resume and cover letter
    then
        lualatex -synctex=1 -interaction=nonstopmode $resumeCmd_de
        mv "${resume_in_de}.pdf" $resume_out_de
        lualatex -synctex=1 -interaction=nonstopmode $coverCmd_de
        mv "${cover_in_de}.pdf" $cover_out_de
    else                # create both english and german
        lualatex -synctex=1 -interaction=nonstopmode $resumeCmd_en
        mv "${resume_in_en}.pdf" $resume_out_en
        lualatex -synctex=1 -interaction=nonstopmode $resumeCmd_de
        mv "${resume_in_de}.pdf" $resume_out_de
        lualatex -synctex=1 -interaction=nonstopmode $coverCmd_en
        mv "${cover_in_en}.pdf" $cover_out_en
        lualatex -synctex=1 -interaction=nonstopmode $coverCmd_de
        mv "${cover_in_de}.pdf" $cover_out_de
    fi
}

function start(){
    echo "=== Please choice language: "
    echo -e "\t1.English\t2.German\t3.Both"
    read lan

    if [[ $lan -ne 1 && $lan -ne 2 && $lan -ne 3 ]]
    then 
        start
    else
        check
        compile $lan
        test $lan
    fi
}

start
make clean


