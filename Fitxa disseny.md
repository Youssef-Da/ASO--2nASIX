# Fitxa 2 — Organització del servei de directori de MusicCloud

## Objectiu

En aquesta sessió hem decidit com organitzar els diferents objectes de MusicCloud dins d'un servei de directori.

Aquesta fitxa forma part de la **documentació de disseny del sistema**. Les decisions que hi indiquis s'utilitzaran posteriorment durant la implantació.
# 1. Objectes que hem de gestionar

MusicCloud necessita gestionar de manera centralitzada diferents tipus d'objectes.

Indica quins tipus d'objectes consideres que ha de contenir el servei de directori.

|Tipus d'objecte|Exemples a MusicCloud|
|---|---|
|Usuaris|Qualsevol treballador de l'empresa com Laia Macias, Roser Alberch|
|Grups|Grups per gestionar permisos, com GR_Administrador|
|Equips|Els departaments com Producció musical|
|Servidors|Servidor de fitxers, servidor de backups, servidor web de la plataforma|
|Comptes d'aplicacions o serveis|Compte del servei de backup, compte del servidor web, compte de la BBDD de backup|

Hi afegiries algun altre tipus d'objecte?

Sí, els ordinadors/equips i les carpetes compartides com a recursos.

---

# 2. Organització mitjançant unitats organitzatives

Proposa les **unitats organitzatives (OU)** principals que utilitzaries a MusicCloud.

|OU|Què contindrà?|Per què la crees?|
|---|---|---|
|OU_Direccio|Usuaris de Direcció|Reflecteix el departament, permet aplicar polítiques pròpies|
|OU_Administracio|Usuaris d'Administració|Gestió centralitzada del departament|
|OU_SuportTecnic|Usuaris de suport tècnic|Gestió centralitzada del departament|
|OU_ProduccioMusical|Usuaris de producció musical|Gestió centralitzada del departament|
|OU_Informatica|Usuaris i comptes tècnics d'Informàtica|Aplicació de polítiques més estrictes als usuaris amb accés administratiu|
|OU_Externs|Usuaris externs|Aïllar-los i aplicar restriccions específiques|
|OU_Servidors|Servidors i comptes de servei|Separar la infraestructura tècnica dels usuaris|

## 2.1. Organització dels usuaris

Dibuixa l'estructura que utilitzaries per organitzar els usuaris de MusicCloud.

```text
MusicCloud
│
└──Usuaris
    |───Direcció
    |───Administració
    |───SuportTecnic
    │───ProduccioMusical
    |───Informatica
    └───Externs
```

---

# 3. OU o grup?

Indica quina opció utilitzaries principalment en cada cas.

|Necessitat|OU|Grup|
|---|:-:|:-:|
|Organitzar els treballadors d'Administració|X|☐|
|Donar accés a la carpeta d'Administració|☐|X|
|Organitzar els ordinadors clients|X|☐|
|Identificar les persones que participen en Campanya Estiu|☐|X|
|Organitzar els servidors|X|☐|
|Donar privilegis als administradors del sistema|☐|X|
|Organitzar els comptes utilitzats per aplicacions|X|☐|

### Explica amb les teves paraules la diferència principal entre una OU i un grup.

**OU:**

És una unitat d'organització que serveix per ubicar objectes de manera jeràrquica i aplicar-hi polítiques. Un objecte normalment nomes pot estar en una OU.

---

**Grup:**

És un conjunt de membres que comparteixen una mateixa necessitat com la necessitat d'accés a recursos. Un usuari pot pertànyer a diferents grups alhora, sense importar la seva OU.

---

---

# 4. Un mateix usuari: ubicació i pertinença

Considera aquest cas:

**Dídac Gassó**

- treballa a Administració;
    
- participa en el projecte Campanya Estiu.
    

Indica:

**En quina OU ubicaries el seu compte?**

---

**A quins grups podria pertànyer?**

---

---

### Per què no és contradictori que estigui en una OU però pertanyi a diversos grups?

---

---

---

# 5. Servei de directori

Explica breument què entens per **servei de directori**.

---

---

Quin problema resol a MusicCloud?

---

---

---

# 6. LDAP

Completa les frases següents.

**LDAP és:**

---

**LDAP no és:**

---

Indica si les afirmacions són certes o falses.

|Afirmació|C|F|
|---|:-:|:-:|
|LDAP és sinònim d'Active Directory|☐|☐|
|LDAP permet accedir i consultar informació d'un directori|☐|☐|
|OpenLDAP és una implementació d'un servei de directori|☐|☐|
|Active Directory utilitza LDAP, entre altres tecnologies|☐|☐|

---

# 7. DIT de MusicCloud

Dibuixa la proposta final de **Directory Information Tree (DIT)** de MusicCloud.

Ha de mostrar, com a mínim:

- usuaris;
    
- grups;
    
- equips;
    
- servidors;
    
- comptes d'aplicacions o serveis;
    
- les subdivisions que consideris necessàries.
    

```text
MusicCloud
│
│
│
│
│
```

---

# 8. Justificació del disseny

Escull **dues decisions** del teu DIT que consideris importants i justifica-les.

### Decisió 1

---

**Justificació:**

---

---

### Decisió 2

---

**Justificació:**

---

---

---

# 9. Comprovació final

Respon breument.

### a) Per què no seria una bona idea guardar tots els usuaris, grups, equips i servidors al mateix nivell sense organitzar-los?

---

---

### b) Per què no hauríem d'utilitzar les OU per substituir els grups de permisos?

---

---

### c) Si MusicCloud passa de 14 a 500 treballadors, quina característica del disseny que has fet avui facilitarà més l'administració?

---

---

---

# Documentació final del sistema

A partir de les decisions preses durant la sessió, deixa definida la proposta que utilitzarem inicialment per a MusicCloud.

## Estructura d'unitats organitzatives

```text
MusicCloud
│
│
│
│
```

## Criteri utilitzat per organitzar els objectes

---

---

## Criteri utilitzat per diferenciar OU i grups
