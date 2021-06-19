CREATE TABLE Utilisateur(
   idUtilisateur INT,
   login VARCHAR(20) NOT NULL,
   nom VARCHAR(50) NOT NULL,
   mail VARCHAR(50) NOT NULL,
   prenom VARCHAR(50) NOT NULL,
   password VARCHAR(50) NOT NULL,
   tel VARCHAR(10),
   typeUtilisateur INT,
   adresse VARCHAR(50),
   PRIMARY KEY(idUtilisateur),
   UNIQUE(login)
);

CREATE TABLE Produit(
   idProduit INT,
   NomProduit VARCHAR(50) NOT NULL,
   PrixProduit DECIMAL(15,2) NOT NULL,
   QteProduit INT,
   Categorie VARCHAR(50) NOT NULL,
   idVendeur INT,
   PRIMARY KEY(idProduit)
);

CREATE TABLE Panier(
   idPanier VARCHAR(50),
   nbProduits INT,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idPanier),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
);

CREATE TABLE Vente(
   idVente INT,
   EtatVente VARCHAR(50) NOT NULL,
   DateVente DATETIME NOT NULL,
   idProduit INT NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idVente),
   FOREIGN KEY(idProduit) REFERENCES Produit(idProduit),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
);

CREATE TABLE Paiement(
   idPaiement INT,
   typePaiement INT,
   PRIMARY KEY(idPaiement)
);

CREATE TABLE CarteBancaire(
   NumCarte INT,
   Montant DECIMAL(15,2),
   cryptogramme INT,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(NumCarte),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
);

CREATE TABLE Administrateur(
   idAdmin INT,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idAdmin),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
);

CREATE TABLE Commande(
   idCommande INT,
   EtatCommande VARCHAR(50) NOT NULL,
   MontantCommande DECIMAL(15,2),
   DateCommande DATETIME,
   idAdmin INT NOT NULL,
   idPaiement INT NOT NULL,
   idUtilisateur INT NOT NULL,
   PRIMARY KEY(idCommande),
   FOREIGN KEY(idAdmin) REFERENCES Administrateur(idAdmin),
   FOREIGN KEY(idPaiement) REFERENCES Paiement(idPaiement),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
);

CREATE TABLE constitue(
   idProduit INT,
   idCommande INT,
   PRIMARY KEY(idProduit, idCommande),
   FOREIGN KEY(idProduit) REFERENCES Produit(idProduit),
   FOREIGN KEY(idCommande) REFERENCES Commande(idCommande)
);

CREATE TABLE administre(
   idAdmin INT,
   idUtilisateur INT,
   ActionAdmin VARCHAR(50),
   PRIMARY KEY(idAdmin, idUtilisateur),
   FOREIGN KEY(idAdmin) REFERENCES Administrateur(idAdmin),
   FOREIGN KEY(idUtilisateur) REFERENCES Utilisateur(idUtilisateur)
);
