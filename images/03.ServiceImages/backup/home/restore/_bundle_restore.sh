#!/bin/bash

restore_name=`echo $1 |sed "/[ ;\\\'\"]/s///g"`

sudo tar -cpf - /tmp/$restore_name