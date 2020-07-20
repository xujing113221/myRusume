#!/bin/bash

clear

cover_in_de="coverletter_de"
cover_out_de="JingXu_Anschreiben_2020.pdf"

resume_in_de="resume_de"
resume_out_de="JingXu_Lebenslauf_2020.pdf"

job_name=
cmd=
resumeCmd=

getInfo(){
    # clear
    cmd=""
    job_name=""
    resumeCmd=""

    echo "=== Please tell me the name of you applicated Job:"
    read job_name
    echo ""

    echo "=== Please tell me the information of your applicated Company:"
    read -p "Name: " comname
    read -p "Address: " addr
    read -p "Postcode, location: " loc
    echo ""

    
    echo "=== Please Choose the following options to tell me the Recipient:"
    echo -e "\t1. Sehr geehrte Damen und Herren,"
    echo -e "\t2. Sehr geehrter Herr Familienname," 
    echo -e "\t3. Sehr geehrte Frau Familienname,"
    read -p "Input your choice nummber: " num

    lettertitle="Sehr geehrte Damen und Herren,"
    if [ $num -eq 2 ]
    then
    read -p "Tell me the name: " hrname
    lettertitle="Sehr geehrter Herr $hrname"
    elif [ $num -eq 3 ]
    then
    read -p "Tell me the name: " hrname
    lettertitle="Sehr geehrter Herr $hrname"
    fi

    echo ""

    if [ -n "$job_name" ]
    then
        cmd="\newcommand{\applicatename}{${job_name}} ${cmd}"
        resumeCmd="\newcommand{\applicatename}{${job_name}}"
    fi

    cmd="\newcommand{\letterbegin}{${lettertitle}} ${cmd}"
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
}

# Praktikant*in Embedded Softwareentwicklung für Brandmeldesysteme
#  Bosch Gruppe
# Grasbrunn bei München


start(){
    getInfo
    echo "=== Please check your inputs!"
    read -p "If wrong, input 1. If right, input any key: " flag
    echo ""

    if [ $flag -eq 1 ]
    then
        start
    fi
}

start
coverCmd="${cmd} \input{${cover_in_de}}"
resumeCmd="${resumeCmd} \input{${resume_in_de}}"

lualatex -synctex=1 -interaction=nonstopmode $coverCmd
mv "${cover_in_de}.pdf" $cover_out_de

lualatex -synctex=1 -interaction=nonstopmode $resumeCmd
mv "${resume_in_de}.pdf" $resume_out_de

make clean



