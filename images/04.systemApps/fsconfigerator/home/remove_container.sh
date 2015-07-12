#!/bin/sh -x


for cmd in $*
 do
  case $cmd in
 	state)
 		rm -r /client/state/*
 		;;
 	logs)
 		rm -r /client/log/*
 		;;
 	fs)	
 		rm -r /dest/fs/*
 		;;
 	all)
 		rm -r /client/log/*
 		rm -r /client/state/*
 		rm -r /dest/fs/*
 		;;
  esac
 done



