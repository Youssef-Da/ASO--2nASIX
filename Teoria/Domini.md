Bosc -1 --------                        --- Domain Controler -- GlobL cATALAG
                |-----musicloud.local
Domini -2 ------            |           --- Domain Controler 2
          |                 |
          |         Podriem tenir Domini web
          |
          ------Controladors de domini (AD-Active Directory  DS-Domain Services)

Objectes -3  
          ----Totes aquestes dades d'objectes es guarden en una base de dades anomenades [NTDS DIT]




Bosc 1-     |
  |         | DNS 
Domain 2-   | musicloud.local
  |         | ldap                  | Tots tenen IP Fixa
Objectes    | Kerberos
            | GC


Distinguished = Com diferenciar el meu nom en un bosc de forma unica

Kerberos: Protocol d'autenticació

ldap:

GC: 