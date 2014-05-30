    CREATE DATABASE app_chiffrage;
    GO

    USE app_chiffrage;
    GO

    CREATE TABLE [dbo].[typeColone] (
        [id]        INT    NOT NULL    IDENTITY(1,1),
        [libelle]    VARCHAR(200)    NOT NULL,
        PRIMARY KEY CLUSTERED ([id] ASC)
    );    
    GO
    CREATE TABLE [dbo].[typeLigne] (
        [id]        INT        NOT NULL    IDENTITY(1,1),
        [libelle]    VARCHAR(200)    NOT NULL,
        PRIMARY KEY CLUSTERED ([id] ASC)
    );
    GO
    CREATE TABLE [dbo].[complexite] (
        [id]        INT    NOT NULL    IDENTITY(1,1),
        [couleur]    INT    NOT NULL,
        PRIMARY KEY CLUSTERED ([id] ASC)
    );
    GO
    CREATE TABLE [dbo].[personnel] (
        [id]    INT        NOT NULL    IDENTITY(1,1),
        [nom]    VARCHAR(200)    NOT NULL,
        PRIMARY KEY CLUSTERED ([id] ASC)
    );
    CREATE TABLE [dbo].[responsable] (
        [id]    INT        NOT NULL    IDENTITY(1,1),
        [nom]    VARCHAR(200)    NOT NULL,
        PRIMARY KEY CLUSTERED ([id] ASC)
    );
    GO
    CREATE TABLE [dbo].[entreprise] (
        [id]    INT        NOT NULL    IDENTITY(1,1),
        [nom]    VARCHAR(200)    NOT NULL,
        [idResponsable]    INT    NOT NULL,
        FOREIGN KEY ([idResponsable]) REFERENCES [dbo].[responsable] ([id]),
        PRIMARY KEY CLUSTERED ([id] ASC)
    );
    GO
    CREATE TABLE [dbo].[projet] (
        [id]    INT        NOT NULL    IDENTITY(1,1),
        [code]    VARCHAR(200)    NOT NULL,
        [nom]    VARCHAR(200)    NOT NULL,
        [debut]    DATE,
        [fin]    DATE,
        [idEntreprise]    INT    NOT NULL,
         [isModel] BIT NOT NULL DEFAULT 0, 
        PRIMARY KEY CLUSTERED ([id]),
        FOREIGN KEY ([idEntreprise]) REFERENCES [dbo].[entreprise] ([id])
    );
    GO
    CREATE TABLE [dbo].[jalon] (
        [id]        INT        NOT NULL    IDENTITY(1,1),
        [nom]        VARCHAR(200)    NOT NULL,
        [datePrevue]    DATE,
        [dateFournie]    DATE,
        [dateValide]    DATE,
        [commentaire]    VARCHAR(200),
        [index]    INT    NOT NULL,
        [idProjet]    INT    NOT NULL,
        FOREIGN KEY ([idProjet]) REFERENCES [dbo].[projet] ([id]),
        PRIMARY KEY CLUSTERED ([id] ASC)
    );
    GO
    CREATE TABLE [dbo].[ligne] (
        [id]        INT        NOT NULL    IDENTITY(1,1),
        [libelle]    VARCHAR(200)    NOT NULL,
        [idProjet]    INT    NOT NULL ,
        [idType]    INT        NOT NULL,
        [commentary]    VARCHAR(200)    NOT NULL,
        FOREIGN KEY ([idType]) REFERENCES [dbo].[typeLigne] ([id]),
        FOREIGN KEY ([idProjet]) REFERENCES [dbo].[projet] ([id]) ON DELETE CASCADE,
        PRIMARY KEY CLUSTERED ([id] ASC)
    )
    GO
    CREATE TABLE [dbo].[colone] (
        [id]        INT        NOT NULL    IDENTITY(1,1),
        [libelle]    VARCHAR(200)    NOT NULL,
        [idProjet]    INT    NOT NULL,
        [idType]    INT        NOT NULL,
        [coeff] FLOAT,
        FOREIGN KEY ([idType]) REFERENCES [dbo].[typeColone] ([id]),
        FOREIGN KEY ([idProjet]) REFERENCES [dbo].[projet] ([id]) ON DELETE CASCADE,
        PRIMARY KEY CLUSTERED ([id] ASC)
    )
    GO
    CREATE TABLE [dbo].[cellule] (
        [idProjet]        INT     NOT NULL,
        [idLigne]        INT     NOT NULL,
        [idColone]        INT     NOT NULL,
        [idComplexite]    INT,
        [idPersonnel]    INT,
        [value]    FLOAT,
        [commentaire] VARCHAR(200), 
    CONSTRAINT [PK_cellule] PRIMARY KEY CLUSTERED ([idLigne] ASC, [idColone] ASC),
        FOREIGN KEY ([idLigne]) REFERENCES [dbo].[ligne] ([id]),
        FOREIGN KEY ([idColone]) REFERENCES [dbo].[colone] ([id]),
        FOREIGN KEY ([idComplexite]) REFERENCES [dbo].[complexite] ([id]),
        FOREIGN KEY ([idPersonnel]) REFERENCES [dbo].[personnel] ([id]) 
    )
    GO
    CREATE TABLE [dbo].[responsableProjet] (
    [idResponsable]     INT    NOT NULL,
    [idProjet]        INT    NOT NULL,
    FOREIGN KEY ([idResponsable]) REFERENCES [dbo].[responsable] ([id]),
    FOREIGN KEY ([idProjet]) REFERENCES [dbo].[projet] ([id]),
    CONSTRAINT [PK_responsableProjet] PRIMARY KEY CLUSTERED
    (
        [idResponsable] ASC,
        [idProjet] ASC
    )
    );
    GO
INSERT INTO [dbo].[complexite] (couleur) VALUES (1);
GO
INSERT INTO [dbo].[complexite] (couleur) VALUES (2);
GO
INSERT INTO [dbo].[complexite] (couleur) VALUES (3);
GO
INSERT INTO [dbo].[typeColone] (libelle) VALUES ('Parties Projet');
GO
INSERT INTO [dbo].[typeColone] (libelle) VALUES ('Etapes');
GO
INSERT INTO [dbo].[typeLigne] (libelle) VALUES ('Tache');
GO
INSERT INTO [dbo].[typeLigne] (libelle) VALUES ('Tache Additionnelle');
GO
INSERT INTO [dbo].[typeLigne] (libelle) VALUES ('Risque');
GO


