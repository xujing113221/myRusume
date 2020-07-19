#!/bin/bash

clear
job_name=""
cover_in_de="coverletter_de"
cover_out_de="JingXu_Anschreiben_2020.pdf"

cmd=

getCoverInfo(){
    # clear
    cmd=""

    echo "=== Please tell me the name of you applicated Job:"
    read job
    cmd="\newcommand{\applicatename}{${job}} ${cmd}"

    echo "=== Please tell me the information of your applicated Company:"
    read -p "Name: " comname
    read -p "Address: " addr
    read -p "Postcode, location: " loc
    
    echo "=== Please Choose the following options to tell me the Recipient:"
    echo -e "\t1. Sehr geehrte Damen und Herren,"
    echo -e "\t2. Sehr geehrter Herr Familienname," 
    echo -e "\t3. Sehr geehrte Frau Familienname,"
    read -p "Input your choice nummber: " num

    lettertitle="Sehr geehrte Damen und Herren,"
    if [ $num -eq 2 ]
    then
    read -p "Tell me the name:" hrname
    lettertitle="Sehr geehrter Herr $hrname"
    elif [ $num -eq 3 ]
    then
    read -p "Tell me the name:" hrname
    lettertitle="Sehr geehrter Herr $hrname"
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
# job_name="\newcommand{\companyaddress}{${company_addr}}"
# echo $job_name
getCoverInfo
coverCmd="${cmd} \input{${cover_in_de}}"

lualatex -synctex=1 -interaction=nonstopmode $coverCmd
mv "${cover_in_de}.pdf" $cover_out_de

make clean

# funWithReturn
# echo "输入的两个数字之和为 $? !"


