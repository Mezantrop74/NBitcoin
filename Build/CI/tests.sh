#!/bin/bash

PROPERTIES=""
if [[ "$TargetFrameworkOverride" ]]; then
    PROPERTIES="$PROPERTIES /p:TargetFrameworkOverride=$TargetFrameworkOverride"
fi
if [[ "$AdditionalDefineConstants" ]]; then
    PROPERTIES="$PROPERTIES /p:AdditionalDefineConstants=$AdditionalDefineConstants"
fi

dotnet build ./NBitcoin.Tests/NBitcoin.Tests.csproj \
             $PROPERTIES \
             -c Release \
             -f $Framework

dotnet test ./NBitcoin.Tests/NBitcoin.Tests.csproj \
            --no-build -v n -c Release \
            -f $Framework.1  \
            --filter "RestClient=RestClient|RPCClient=RPCClient|Protocol=Protocol|Core=Core|UnitTest=UnitTest|Altcoins=Altcoins" \
            -p:ParallelizeTestCollections=false  < /dev/null