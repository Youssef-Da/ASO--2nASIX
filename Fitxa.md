# Fitxa 1 — Anàlisi inicial de MusicCloud

**Nom i cognoms:** Youssef Dahmouni Sadki

**Data:** 17/09/2026 

**Equip / parella:** N/A

## Objectiu

MusicCloud necessita reorganitzar la seva infraestructura informàtica. Abans d'instal·lar o configurar cap servei, cal entendre:

- qui treballa a l'empresa;
    
- quines funcions té cada persona;
    
- quins recursos existeixen;
    
- qui necessita accedir a cada recurs;
    
- com podem gestionar aquests accessos de manera eficient.
    

---

# 1. Conèixer MusicCloud

Consulta la informació disponible sobre els departaments, treballadors i perfils d'usuari de MusicCloud.

Completa la taula següent.

| Persona | Departament | Funció / responsabilitat | Necessita privilegis especials? Per què? |
|---|---|---|---|
| Aina Ciurans | Direcció | Gestió general de l'empresa | Sí, accés total als recursos de Direcció|
| Laia Macias | Cap d'Administració| Coordina el departament, factures/contractes | Sí, és l'única amb permisos de lectura i escritura a gestio_departament |
| Dídac Gassó | Administració | Factures, contractes, documentació | No, accés estàndard del departament |
| Lluïsa Richart | Cap del suport tècnic | Coordina incidències i manteniment | Sí, permis de lectura i escritura exclusiu agestio_departament i scripts |
| Meritxell Reglat | Cap de producció musical | Coordina gestió de continguts | Sí, permis de lectura i escitura exclusiu a gestio_departament |
| Talia Costas | Cap d'Informàtica | Suport i administració del sistema | Sí, accés ADM als recursos crítics com els backups, logs, configuracions etc... |
| Alex Soriano | Informàtica | Suport tècnic del sistema | Sí, per la naturalesa tècnica del departament |
| Pere Espinalt | Extern | Col·laboració puntual/externa | No, accés molt limitat, només a intercanvi |


### 1.1. Reflexió

Quines diferències observes entre un **treballador**, un **departament** i una **funció o responsabilitat**?

El treballador és la persona concreta, la identitat individual dins el sistema. El departament és el grup organitzatiu al qual pertany el treballador. I la funció o responsabilitat és el rol que exerceix un treballador, per exemple el cap de departament, que determina permisos concrets més enllà dels del departament.


**Hi ha persones que, pel seu càrrec o funció, necessiten accessos diferents dels altres membres del seu departament?**

Posa'n algun exemple:

Sí per exemple els caps de departament que tenen accés exclusiu a gestio_departament, i el personal d'Informàtica, que té accés d'administrador a recursos de sistema que la resta de departaments no té.


# 2. Recursos de l'empresa

Analitza l'estructura d'informació de MusicCloud.

Classifica alguns dels recursos següents segons la seva finalitat.

| Recurs | Qui l'hauria d'utilitzar? | Per a què? |
|---|---|---|
| `/empresa/comu/intercanvi` | Tots els treballadors i usuaris externs | Intercanvi temporal de documents amb externs |
| `/empresa/comu/comunicats` | Tots els treballadors (excepte externs) | Consultar comunicats interns de l'empresa |
| `/empresa/departaments/administracio/compartida` | Treballadors d'Administració | Documents compartits del dia a dia del departament |
| `/empresa/departaments/administracio/gestio_departament` | Cap d'Administració (Laia) | Gestió i validació de documents interns del departament |
| `/empresa/projectes/campanya_estiu` | Membres assignats al projecte (de diversos departaments) | Treball col·laboratiu en el projecte transversal |
| `/empresa/administracio_sistema/backups` | Informàtica | Gestió tècnica de còpies de seguretat del sistema |


---

# 3. Qui ha de poder fer què?

Per a cada situació, indica quin nivell d'accés consideres adequat.

Utilitza:

- **NA** → sense accés
    
- **L** → lectura
    
- **L/E** → lectura i escriptura
    
- **ADM** → administració
    

No busquis encara una solució tècnica. Pensa només en les necessitats de l'empresa.

|Situació|Accés proposat|Justificació|
|---|---|---|
|Dídac accedeix a la carpeta compartida d'Administració|L/E|És treballador del departament, necessita treballar amb els documents del dia a dia|
|Laia accedeix a la gestió del departament d'Administració|L/E|És la cap, és l'única que ha de validar/gestionar documents interns|
|Pere, treballador extern, accedeix als comunicats interns|NA|Els comunicats són informació interna, no destinada a externs|
|Talia accedeix als backups del sistema|ADM|És cap d'Informàtica, responsable del manteniment tècnic|
|Un membre de Producció musical accedeix a la carpeta d'Administració|NA|No pertany al departament, informació d'un altre àmbit|
|Un participant de campanya_estiu accedeix als fitxers del projecte|L/E| És membre assignat al projecte transversal, necessita treballar-hi|

---

# 4. Primer problema: com assignem els permisos?

Imagina que MusicCloud té només quatre treballadors:

- Anna
    
- Biel
    
- Carla
    
- David
    

Tots quatre treballen al mateix departament i necessiten accedir a la mateixa carpeta.

Una possible solució seria configurar:

```text
Anna  → lectura/escriptura
Biel  → lectura/escriptura
Carla → lectura/escriptura
David → lectura/escriptura
```

### 4.1.

Què passaria si l'empresa tingués **100 treballadors** amb el mateix tipus d'accés?

---

---

### 4.2.

Què passaria cada vegada que s'incorporés una persona nova?

---

---

### 4.3.

Què passaria quan una persona canviés de departament?

---

---

### 4.4.

Proposa una manera de gestionar aquestes persones conjuntament.

No cal que coneguis encara el nom tècnic de la solució.

---

---

---

---

# 5. Canvis a MusicCloud

Ara es produeixen aquests tres canvis:

### Cas A

Dídac deixa Administració i passa a Producció musical.

Quins accessos hauria de perdre?

---

Quins accessos hauria d'obtenir?

---

---

### Cas B

S'incorpora una nova treballadora al departament d'Administració.

Quins accessos caldria configurar?

---

---

---

### Cas C

Pere Espinalt deixa de col·laborar amb MusicCloud.

Què hauríem de fer amb els seus accessos?

---

---

---

# 6. Busquem una solució millor

Suposa ara que podem crear conjunts de persones que comparteixen unes mateixes necessitats d'accés.

Per exemple:

```text
Administració
    ├── Dídac
    ├── Laia
    └── Roser
```

I podem donar permisos directament al conjunt:

```text
Administració → carpeta_administracio → L/E
```

### 6.1.

Quin avantatge té aquesta solució respecte a donar permisos persona per persona?

---

---

### 6.2.

Si Dídac passa d'Administració a Producció musical, què caldria modificar?

---

---

### 6.3.

Com anomenaries aquests conjunts de persones?

---

---

# 7. Primera proposta per a MusicCloud

A partir de l'organització de l'empresa, proposa els primers conjunts de persones que crearies.

**No cal trobar encara la solució definitiva.**

|Nom proposat|Qui hi pertanyeria?|Per què existeix aquest conjunt?|
|---|---|---|
||||
||||
||||
||||
||||

---

# 8. Cas que complica el model

Laia treballa al departament d'Administració, però també és la responsable del departament.

És suficient que pertanyi només al conjunt `Administració`?

☐ Sí  
☐ No

Per què?

---

---

Quina possible solució proposes?

---

---

---

# 9. Un altre cas

Diverses persones de departaments diferents participen temporalment en el projecte:

```text
Campanya Estiu
```

Creus que hauríem de canviar-les de departament?

☐ Sí  
☐ No

Si no, com podríem donar-los accés als recursos del projecte?

---

---

---

# 10. Conclusions

Completa les frases amb les teves paraules.

### Usuari

Un usuari representa:

---

### Recurs

Un recurs és:

---

### Permís

Un permís determina:

---

### Grup

Un grup serveix per:

---

---

# 11. Regla de mínim privilegi

Analitza aquesta afirmació:

> Un usuari només hauria de tenir els permisos estrictament necessaris per realitzar la seva feina.

Explica amb les teves paraules què significa.

---

---

Posa un exemple relacionat amb MusicCloud.

---

---

---

# 12. Pregunta final

Imagina que demà MusicCloud passa de 14 treballadors a 500.

Quina de les dues estratègies consideres més adequada?

☐ Assignar permisos individualment a cada usuari.

☐ Organitzar els usuaris segons les seves necessitats i assignar permisos a aquests conjunts.

Justifica la resposta.