A Docker image of [GModPatchTool](https://github.com/solsticegamestudios/GModPatchTool)

Example: 

```
docker run -it \
    --rm --name "gmod-cef-codec" \
    -v "/home/workstation/.var/app/com.valvesoftware.Steam/.steam/steam:/home/gmod/.steam/steam" \
    -v "/mnt/games:/mnt/games" \
    ethorbit/gmodpatchtool:latest
```

The first volume map is to your Steam path, the second one is to the other drive where Garry's Mod is installed, if you have it installed to another drive. GModCEFCodecFix needs both.
