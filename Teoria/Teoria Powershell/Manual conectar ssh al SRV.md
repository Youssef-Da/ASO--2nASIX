# Com connectar SSH a Visual Studio Code

## 1. Instal·lar el servei SSH
Instal·lem i activem el servei **OpenSSH Server** al Windows Server Core.

## 2. Configurar l'SSH
Accedim al fitxer de configuració de l'SSH (`sshd_config`) i canviem l'opció següent:

```text
PasswordAuthentication yes
```

Això permet autenticar-nos amb contrasenya. Després, reiniciem el servei SSH perquè s'apliquin els canvis.

## 3. Instal·lar l'extensió de Visual Studio Code
Obrim Visual Studio Code i instal·lem l'extensió **Remote - SSH**, desenvolupada per Microsoft.

## 4. Comprovar que l'SSH funciona
Des de la terminal del Windows Server Core, executem:

```bash
ssh administrator@127.0.0.1
```

Si ens demana la contrasenya, vol dir que el servei SSH respon correctament. Aquesta prova es fa amb `localhost` i només comprova la connexió local.

Per comprovar l'accés des d'un altre ordinador, hem d'utilitzar la IP del servidor. Quan acabem la prova, sortim de la sessió amb:

```bash
exit
```

## 5. Revisar el tallafoc
Comprovem que el tallafoc de Windows permet les connexions SSH entrants pel **port TCP 22**.

Si no existeix una regla adequada, n'hem de crear una per permetre aquest trànsit.

## 6. Connectar-nos des de Visual Studio Code
1. Obrim Visual Studio Code.
2. Premem `Ctrl + Shift + P`.
3. Seleccionem **Remote-SSH: Connect to Host...**.
4. Escollim **Add New SSH Host...**.
5. Introduïm la connexió amb la IP del servidor:

   ```bash
   ssh administrator@IP_DEL_SERVIDOR
   ```

6. Seleccionem el fitxer de configuració SSH on volem desar la connexió.
7. Tornem a **Remote-SSH: Connect to Host...** i seleccionem el servidor.
8. Si ens ho demana, introduïm la contrasenya i acceptem la clau del servidor si és la primera connexió i n'hem verificat l'autenticitat.

## 7. Comprovar la connexió
Quan la connexió s'hagi establert, Visual Studio Code mostrarà que estem connectats al servidor remot.

Ja podem obrir carpetes, editar fitxers i treballar directament al Windows Server Core des de Visual Studio Code.