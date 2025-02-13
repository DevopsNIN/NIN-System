
delete from wms.mUserProgram;
delete from wms.mProgram;
delete from wms.mModule;
delete from wms.mUser;

INSERT INTO wms.mUser (sUser, sPasswd, sName) VALUES ('2', '3', 'Tester');

INSERT INTO wms.mModule(sModule, sDesc) VALUES ('Admin', 'Administration');
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('User', 'Admin', '/Admin/User', 'User Administration', true);
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'User', 'W');

INSERT INTO wms.mModule(sModule, sDesc) VALUES ('Main', 'Maintenance');
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Item', 'Main', '/Main/Item', 'Item', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Box', 'Main', '/Main/Box', 'Box', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Rack', 'Main', '/Main/Rack', 'Rack', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Period', 'Main', '/Main/Period', 'Period', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('ShipTo', 'Main', '/Main/ShipTo', 'Shipping To Location', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Delivery2', 'Main', '/Main/Delivery2', 'Delivery', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('DeliveryOrder', 'Main', '/Main/DeliveryOrder', 'Delivery Order Maintenance', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Delivery3', 'Main', '/Main/Delivery3', 'Delivery Report', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Delivery4', 'Main', '/Main/Delivery4', 'Delivery Update', true);
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Item', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Box', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Rack', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Period', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'ShipTo', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'DeliveryOrder', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Delivery2', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Delivery3', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Delivery4', 'W');

INSERT INTO wms.mModule(sModule, sDesc) VALUES ('Exch', 'Data Exchange');
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Impr', 'Exch', '/Exch/Import', 'Import List Exchange', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('SPL', 'Exch', '/Exch/PickOrder', 'Picking Order Exchange', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('DO', 'Exch', '/Exch/DO', 'Delivery Order Exchange', true);
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Impr', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'SPL', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'DO', 'W');

INSERT INTO wms.mModule(sModule, sDesc) VALUES ('Ctrl', 'Gate Control');
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Dlvr', 'Ctrl', '/Ctrl/Delivery', 'Delivery', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('ExIn', 'Ctrl', '/Ctrl/ExtraIn', 'Sort Out', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('ExOut', 'Ctrl', '/Ctrl/ExtraOut', 'Return', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Recv', 'Ctrl', '/Ctrl/Receiving', 'Incoming', true);
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Recv', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'ExIn', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'ExOut', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Dlvr', 'W');

INSERT INTO wms.mModule(sModule, sDesc) VALUES ('Plan', 'Planning');
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Incoming', 'Plan', '/Plan/Receiving', 'Incoming Report', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('Delivery', 'Plan', '/Plan/Delivery', 'Delivery Report', true);
INSERT INTO wms.mProgram(sProgram, sModule, sPath, sDesc, bDisplay) VALUES ('StockList', 'Plan', '/Plan/StockList', 'Stock List', true);
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Incoming', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'Delivery', 'W');
INSERT INTO wms.mUserProgram(sUser, sProgram, cAccess) VALUES ('2', 'StockList', 'W');
