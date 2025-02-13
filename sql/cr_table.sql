CREATE SCHEMA wms;

-- System Data ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE wms.mUser
(
    sUser varchar(6) NOT NULL,
    sPasswd varchar(12) NOT NULL,
    sName varchar(32) NOT NULL,
    dUser date,
    dPasswd date
);
ALTER TABLE wms.mUser ADD CONSTRAINT pk_mUser PRIMARY KEY (sUser);

CREATE TABLE wms.mModule
(
    sModule varchar(32) NOT NULL,
    sDesc varchar(64)    
);
ALTER TABLE wms.mModule ADD CONSTRAINT pk_mModule PRIMARY KEY (sModule);

CREATE TABLE wms.mProgram
(
    sProgram varchar(32) NOT NULL,
    sModule varchar(32) NOT NULL,
    sPath varchar(64) NOT NULL,
    sDesc varchar(64),
    bDisplay boolean NOT NULL DEFAULT true
);
ALTER TABLE wms.mProgram ADD CONSTRAINT pk_mProgram PRIMARY KEY (sProgram);
ALTER TABLE wms.mProgram ADD CONSTRAINT fk_mProgram_mModule FOREIGN KEY (sModule) REFERENCES wms.mModule(sModule);

CREATE TABLE wms.mUserProgram
(
    sUser varchar(6) NOT NULL,
    sProgram varchar(32) NOT NULL,
    cAccess char NOT NULL
);
ALTER TABLE wms.mUserProgram ADD CONSTRAINT pk_mUserProgram PRIMARY KEY (sUser, sProgram);
ALTER TABLE wms.mUserProgram ADD CONSTRAINT fk_mUserProgram_mUser FOREIGN KEY (sUser) REFERENCES wms.mUser(sUser);
ALTER TABLE wms.mUserProgram ADD CONSTRAINT fk_mUserProgram_mProgram FOREIGN KEY (sProgram) REFERENCES wms.mProgram(sProgram);

-- Core Information -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE wms.mPeriod
(
    iPeriod INT NOT NULL,
    dStart DATE NOT NULL,
    dEnd DATE NOT NULL,
    sStat VARCHAR(6) DEFAULT 'OPEN'
);
ALTER TABLE wms.mPeriod ADD CONSTRAINT pk_mPeriod PRIMARY KEY(iPeriod);

CREATE TABLE wms.mPallet
(
    sPallet VARCHAR(8) NOT NULL,
    iType INT NOT NULL DEFAULT 1,
    sDesc VARCHAR(32)
);
ALTER TABLE wms.mPallet ADD CONSTRAINT pk_mPallet PRIMARY KEY(sPallet);

CREATE TABLE wms.mRack
(
    sRack VARCHAR(8) NOT NULL,
    sDesc VARCHAR(64),
    sStat VARCHAR(6) DEFAULT 'OPEN'
);
ALTER TABLE wms.mRack ADD CONSTRAINT pk_mRack PRIMARY KEY (sRack);

CREATE TABLE wms.mShipTo
(
    sCust VARCHAR(16) NOT NULL,
    sShipTo VARCHAR(16) NOT NULL DEFAULT 'MAIN',
    sName VARCHAR(32),
    sAddr VARCHAR(64)
);
ALTER TABLE wms.mShipTo ADD CONSTRAINT pk_mShipTo PRIMARY KEY (sCust, sShipTo);

CREATE TABLE wms.mBox
(
    sBox VARCHAR(32) NOT NULL,
    sItem VARCHAR(150),
    sLot VARCHAR(32),
    dMfg DATE,
    fQty NUMERIC(17,5) DEFAULT 0,
    sRack VARCHAR(8) DEFAULT NULL,
    sStat VARCHAR(6) DEFAULT 'INTR'
);
ALTER TABLE wms.mBox ADD CONSTRAINT pk_mBox PRIMARY KEY (sBox);
CREATE index idx_mBox_sItem ON wms.mBox(sItem);

CREATE TABLE wms.mRecv
(
    sRecv VARCHAR(16) NOT NULL,
    iPeriod INT NOT NULL,
    tStart TIMESTAMP DEFAULT now(),
    tEnd TIMESTAMP,
    sStat VARCHAR(6) DEFAULT 'OPEN',
    sOperOpen VARCHAR(32) DEFAULT '',
    sOperClose VARCHAR(32) DEFAULT ''
);
ALTER TABLE wms.mRecv ADD CONSTRAINT pk_mRecv PRIMARY KEY (sRecv);
ALTER TABLE wms.mRecv ADD CONSTRAINT fk_mRecv_mPeriod FOREIGN KEY(iPeriod) REFERENCES wms.mPeriod(iPeriod);

CREATE TABLE wms.mPickOrder
(
    sPick VARCHAR(24) NOT NULL,
    sCust VARCHAR(16) NOT NULL,
    sShipTo VARCHAR(16) NOT NULL,
    tSTD TIMESTAMP,
    tSTA TIMESTAMP,
    sStat VARCHAR(6) DEFAULT 'PLAN'
);
ALTER TABLE wms.mPickOrder ADD CONSTRAINT pk_mPickOrder PRIMARY KEY (sPick);
--ALTER TABLE wms.mPickOrder ADD CONSTRAINT fk_mPickOrder_mPeriod FOREIGN KEY(iPeriod) REFERENCES wms.mPeriod(iPeriod);
--ALTER TABLE wms.mPickOrder ADD CONSTRAINT fk_mPickOrder_mShipTo FOREIGN KEY (sCust, sShipTo) REFERENCES wms.mShipTo(sCust, sShipTo);

CREATE TABLE wms.mPack
(
    sPack VARCHAR(24) NOT NULL,    
    iPeriod INT NOT NULL,
    sStat VARCHAR(6) DEFAULT 'PLAN'
);
ALTER TABLE wms.mPack ADD CONSTRAINT pk_mPack PRIMARY KEY (sPack);

CREATE TABLE wms.mDO
(
    sDO VARCHAR(64) NOT NULL,    
    sCust VARCHAR(16),
    sShipTo VARCHAR(16),
    sStat VARCHAR(6) DEFAULT 'PLAN'
);
ALTER TABLE wms.mDO ADD CONSTRAINT pk_mDO PRIMARY KEY(sDO);

CREATE TABLE wms.mDlvr
(
    sDlvr VARCHAR(16) NOT NULL,
    iPeriod INT NOT NULL,
    tStart TIMESTAMP DEFAULT now(),
    tEnd TIMESTAMP,
    sStat VARCHAR(6) DEFAULT 'OPEN',
    sOperOpen VARCHAR(32) DEFAULT '',
    sOperClose VARCHAR(32) DEFAULT ''
);
ALTER TABLE wms.mDlvr ADD CONSTRAINT pk_mDlvr PRIMARY KEY (sDlvr);
ALTER TABLE wms.mDlvr ADD CONSTRAINT fk_mDlvr_mPeriod FOREIGN KEY(iPeriod) REFERENCES wms.mPeriod(iPeriod);

-- Receiving Process ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE wms.tRecvBox
(
    sRecv VARCHAR(16) NOT NULL,
    sBox VARCHAR(32) NOT NULL,
    fQty NUMERIC(17,5) DEFAULT 0,
    sPallet VARCHAR(8) DEFAULT '',
    sOper VARCHAR(32) DEFAULT ''
);
ALTER TABLE wms.tRecvBox ADD CONSTRAINT pk_tRecvBox PRIMARY KEY (sRecv, sBox);
ALTER TABLE wms.tRecvBox ADD CONSTRAINT fk_tRecvBox_mRecv FOREIGN KEY (sRecv) REFERENCES wms.mRecv(sRecv);
ALTER TABLE wms.tRecvBox ADD CONSTRAINT fk_tRecvBox_mBox FOREIGN KEY (sBox) REFERENCES wms.mBox(sBox);
CREATE INDEX idxRecvBoxPallet ON wms.tRecvBox(sRecv, sPallet);

-- Picking Process --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE wms.tPickOrder
(
    sPick VARCHAR(24) NOT NULL,
    sRefNo VARCHAR(16) NOT NULL,
    iRefSeq INT NOT NULL,
    sItem VARCHAR(32) NOT NULL,
    fQty NUMERIC(17,5) DEFAULT 0
);
ALTER TABLE wms.tPickOrder ADD CONSTRAINT pk_tPickOrder PRIMARY KEY (sPick, sRefNo, iRefSeq);
ALTER TABLE wms.tPickOrder ADD CONSTRAINT fk_tPickOrder_mPickOrder FOREIGN KEY (sPick) REFERENCES wms.mPickOrder(sPick);

CREATE TABLE wms.tPickBox
(
    sPick VARCHAR(24) NOT NULL,
    sBox VARCHAR(32) NOT NULL,
    fQty NUMERIC(17,5) DEFAULT 0,
    sOper VARCHAR(32) DEFAULT '' 
);
ALTER TABLE wms.tPickBox ADD CONSTRAINT pk_tPickBox PRIMARY KEY (sPick, sBox);
ALTER TABLE wms.tPickBox ADD CONSTRAINT fk_tPickBox_mPickOrder FOREIGN KEY (sPick) REFERENCES wms.mPickOrder(sPick);
ALTER TABLE wms.tPickBox ADD CONSTRAINT fk_tPickBox_mBox FOREIGN KEY (sBox) REFERENCES wms.mBox(sBox);

-- Packing Process --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE wms.tPack
(
    sPack VARCHAR(24) NOT NULL,
    sPick VARCHAR(24) NOT NULL,
    sRefNo VARCHAR(16) NOT NULL,
    iRefSeq INT NOT NULL
);
ALTER TABLE wms.tPack ADD CONSTRAINT pk_tPack PRIMARY KEY (sPack, sPick, sRefNo, iRefSeq);
ALTER TABLE wms.tPack ADD CONSTRAINT fk_tPack_tPickOrder FOREIGN KEY (sPick, sRefNo, iRefSeq) REFERENCES wms.tPickOrder(sPick, sRefNo, iRefSeq);

CREATE TABLE wms.tPackBox
(
    sPack VARCHAR(24) NOT NULL,
    sBox VARCHAR(32) NOT NULL,
    sPick VARCHAR(24) NOT NULL,
    sRefNo VARCHAR(16) NOT NULL,
    iRefSeq INT NOT NULL    
);
ALTER TABLE wms.tPackBox ADD CONSTRAINT pk_tPackBox PRIMARY KEY (sPack, sBox);
ALTER TABLE wms.tPackBox ADD CONSTRAINT fk_tPackBox_tPack FOREIGN KEY (sPack) REFERENCES wms.mPack(sPack);
ALTER TABLE wms.tPackBox ADD CONSTRAINT fk_tPackBox_mBox FOREIGN KEY (sBox) REFERENCES wms.mBox(sBox);

-- Delivery Process -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE wms.sDO
(
    sDO VARCHAR(32) NOT NULL,
    iSeq INT NOT NULL,
    sItem VARCHAR(32) NOT NULL,
    fQty NUMERIC(17,5) DEFAULT 0
);
ALTER TABLE wms.sDO ADD CONSTRAINT pk_sDO PRIMARY KEY (sDO, iSeq);
ALTER TABLE wms.sDO ADD CONSTRAINT fk_sDO_mDO FOREIGN KEY (sDO) REFERENCES wms.mDO(sDO);

CREATE TABLE wms.tDlvrBox
(
    sDlvr VARCHAR(16) NOT NULL,
    sBox VARCHAR(32) NOT NULL,
    fQty NUMERIC(17,5) DEFAULT 0,
    sPallet VARCHAR(8) DEFAULT '',
    sOper VARCHAR(32) DEFAULT ''
);
ALTER TABLE wms.tDlvrBox ADD CONSTRAINT pk_tDlvrBox PRIMARY KEY (sDlvr, sBox);
ALTER TABLE wms.tDlvrBox ADD CONSTRAINT fk_tDlvrBox_mDlvr FOREIGN KEY (sDlvr) REFERENCES wms.mDlvr(sDlvr);
ALTER TABLE wms.tDlvrBox ADD CONSTRAINT fk_tDlvrBox_mBox FOREIGN KEY (sBox) REFERENCES wms.mBox(sBox);
CREATE INDEX idxDlvrBoxPallet ON wms.tDlvrBox(sDlvr, sPallet);

CREATE TABLE wms.tDODlvr
(
    sDO VARCHAR(32) NOT NULL,    
    sDlvr VARCHAR(32) NOT NULL,
    sOper VARCHAR(32) DEFAULT ''
);
ALTER TABLE wms.tDODlvr ADD CONSTRAINT pk_tDODlvr PRIMARY KEY (sDO);
ALTER TABLE wms.tDODlvr ADD CONSTRAINT fk_tDODlvr_mDO FOREIGN KEY (sDO) REFERENCES wms.mDO(sDO);
ALTER TABLE wms.tDODlvr ADD CONSTRAINT fk_tDODlvr_mDlvr FOREIGN KEY (sDlvr) REFERENCES wms.mDlvr(sDlvr);

CREATE TABLE wms.tDOBox
(
    sDO VARCHAR(32) NOT NULL,
    iSeq INT NOT NULL,
    sBox VARCHAR(32) NOT NULL,
    fQty NUMERIC(17,5) DEFAULT 0    
);
ALTER TABLE wms.tDOBox ADD CONSTRAINT pk_tDOBox PRIMARY KEY (sDO, iSeq, sBox);
ALTER TABLE wms.tDOBox ADD CONSTRAINT fk_tDOBox_sDO FOREIGN KEY (sDO, iSeq) REFERENCES wms.sDO(sDO, iSeq);
ALTER TABLE wms.tDOBox ADD CONSTRAINT fk_tDOBox_mBox FOREIGN KEY (sBox) REFERENCES wms.mBox(sBox);

-- Cycle Count Process ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE wms.tPeriodBox
(
    iPeriod INT NOT NULL,
    sBox VARCHAR(32) NOT NULL,
    fQty NUMERIC(17,5) DEFAULT 0,
    fQtyCount NUMERIC(17,5) DEFAULT 0,
    sRack VARCHAR(8) DEFAULT NULL,
    sRackCount VARCHAR(8) DEFAULT NULL,
    sStat VARCHAR(6) DEFAULT NULL,
    sStatCount VARCHAR(6) DEFAULT NULL,
    sOper VARCHAR(32) DEFAULT ''
);
ALTER TABLE wms.tPeriodBox ADD CONSTRAINT pk_tPeriodBox PRIMARY KEY (iPeriod, sBox);
ALTER TABLE wms.tPeriodBox ADD CONSTRAINT fk_tPeriodBox_mPeriod FOREIGN KEY (iPeriod) REFERENCES wms.mPeriod(iPeriod);

-- Box Transaction --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE wms.lBox
(
    sBox VARCHAR(32) NOT NULL,
    tStamp TIMESTAMP NOT NULL DEFAULT now(),
    iPeriod INT NOT NULL,
    sType VARCHAR(6) DEFAULT 'RECV',
    sRef VARCHAR(32) DEFAULT '',
    iRef NUMERIC(9) DEFAULT 0,
    fValue NUMERIC(17,5) DEFAULT 0,
    sValue VARCHAR(64) DEFAULT '',
    sOper VARCHAR(32) DEFAULT ''
);
ALTER TABLE wms.lBox ADD CONSTRAINT pk_lBox PRIMARY KEY (sBox, tStamp);
ALTER TABLE wms.lBox ADD CONSTRAINT fk_lBox_mBox FOREIGN KEY (sBox) REFERENCES wms.mBox (sBox);
ALTER TABLE wms.lBox ADD CONSTRAINT fk_lBox_mPeriod FOREIGN KEY (iPeriod) REFERENCES wms.mPeriod (iPeriod);
CREATE INDEX idx_lBox_Type_Ref ON wms.lBox(sType, sRef, iRef);
