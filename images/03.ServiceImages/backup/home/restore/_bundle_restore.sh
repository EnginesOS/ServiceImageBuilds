#!/bin/bash

restore_name=`echo $1 |sed "/[ ;\\\'\"]/s///g"`

tar -cpf - /tmp/$restore_name