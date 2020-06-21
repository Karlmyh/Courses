#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar 17 22:28:41 2020

@author: mayuheng
"""
import numpy as np
def calculate(label, score,target):
    if target=="AUC-PR":
        n=len(label)
        AUCPR=np.zeros(n)
        precision=np.zeros(n+1)
        recall=np.zeros(n+1)
        precision[0]=1
        recall[0]=0
        for i in range(1,n+1):
            precision[i]=np.sum(label[0:i])/i
            recall[i]=np.sum(label[0:i])/np.sum(label)
            AUCPR[i-1]=(recall[i]-recall[i-1])*(precision[i]+precision[i-1])/2
        return np.sum(AUCPR)
    elif target=="AP":
        n=len(label)
        AP=np.zeros(n)
        precision=np.zeros(n+1)
        recall=np.zeros(n+1)
        precision[0]=1
        recall[0]=0
        for i in range(1,n+1):
            precision[i]=np.sum(label[0:i])/i
            recall[i]=np.sum(label[0:i])/np.sum(label)
            AP[i-1]=(recall[i]-recall[i-1])*precision[i]
        return np.sum(AP)
    else:
        return 0
        