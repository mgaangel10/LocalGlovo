

DELETE FROM producto_ingredientes;
INSERT INTO usuario (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled,foto_url) VALUES ('5d818565-99f9-4d80-920e-8259c6ecb8e6', 'Pedro','pepe', 'ToRechulon', 'pedro@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQciKN1y59CDYMq-IALg7OUijN7hIiM8hdzKw&usqp=CAU');
INSERT INTO usuario_roles ( roles,usuario_id) VALUES (0,'5d818565-99f9-4d80-920e-8259c6ecb8e6');
INSERT INTO usuario (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled,foto_url) VALUES ('6f1b8ae1-d1cb-491d-a73c-abf8c3e829d0', 'Jose','perez', 'ToRechulon', 'jose@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQciKN1y59CDYMq-IALg7OUijN7hIiM8hdzKw&usqp=CAU');
INSERT INTO usuario_roles ( roles,usuario_id) VALUES (0,'6f1b8ae1-d1cb-491d-a73c-abf8c3e829d0');
INSERT INTO usuario (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled,foto_url) VALUES ('e9ef3d6f-5e47-4218-bd23-495ce3176dbd', 'Antonio','macias', 'ToRechulon', 'antonio@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQciKN1y59CDYMq-IALg7OUijN7hIiM8hdzKw&usqp=CAU');
INSERT INTO usuario_roles ( roles,usuario_id) VALUES (0,'e9ef3d6f-5e47-4218-bd23-495ce3176dbd');
INSERT INTO usuario (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled,foto_url) VALUES ('8e221cbb-7edd-4943-b643-fcb2f34deb19', 'Juan','pepe', 'ToRechulon', 'juan@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true,'https://previews.123rf.com/images/jemastock/jemastock1712/jemastock171209328/91942350-dise%C3%B1o-gr%C3%A1fico-del-ejemplo-del-vector-del-icono-del-avatar-del-perfil-del-hombre-de-negocios.jpg');
INSERT INTO usuario_roles ( roles,usuario_id) VALUES (0,'8e221cbb-7edd-4943-b643-fcb2f34deb19');
INSERT INTO administrador (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled,foto_url) VALUES ('a23c61eb-4a5a-4cdd-beea-44234583ff4c', 'Angel','perez', 'ToRechulon', 'angel@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQciKN1y59CDYMq-IALg7OUijN7hIiM8hdzKw&usqp=CAU');
INSERT INTO administrador_roles ( roles,administrador_id) VALUES (1,'a23c61eb-4a5a-4cdd-beea-44234583ff4c');
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction,imagen,likes)VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'Las Lozas', 37.2700843067059, -6.063028856447782, 4.8, 'La puebla del rio','restaurante5.jpeg',false);
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction,imagen,likes)VALUES ('123e4567-e89b-12d3-a456-426614174000', 'Felipon', 37.27203372064043, -6.066180282066359, 4.8, 'La puebla del rio','carniceria5.jpeg',false);
INSERT INTO comercio_categorias(comercio_id,categorias)VALUES('f89f898a-70aa-48d5-8088-3f3c892d7bae','RESTAURANTE');
INSERT INTO comercio_categorias(comercio_id,categorias)VALUES('123e4567-e89b-12d3-a456-426614174000','CARNECERIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda Bendicion', 37.272149626637564, -6.06192884623146, 4.5, 'La puebla del rio', 'tiendaRopa.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('7bb2e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDAROPA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'Bar Osso', 37.272804495539006, -6.062129797459527, 4.2, 'La puebla del rio', 'bar.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'BAR');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda G Fashion', 37.2708028410246, -6.06328770833118, 4.1, 'Sevilla', 'tiendaRopa1.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDAROPA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9', 'Supermercado', 37.268698190432744, -6.065863976966079, 4.6, 'Coria del Rio', 'tiendaComestibles.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDACOMESTIBLES');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('bee6e900-9dad-11d1-80b4-00c04fd430c9', 'Carnicería 6', 37.26693788942789, -6.063505949827319, 4.7, 'Palomares del rio', 'carniceria.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('bee6e900-9dad-11d1-80b4-00c04fd430c9', 'CARNECERIA');

INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('550e8400-e29b-41d4-a716-446655440000', 'Carnicería 5', 37.26693788942789, -6.063505949827319, 4.7, 'Palomares del rio', 'carniceria1.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('550e8400-e29b-41d4-a716-446655440000', 'CARNECERIA');

INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('6ba7b810-9dad-11d1-80b4-00c04fd430c8', 'Carnicería 4', 37.26693788942789, -6.063505949827319, 4.7, 'Palomares del rio', 'carniceria2.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('6ba7b810-9dad-11d1-80b4-00c04fd430c8', 'CARNECERIA');

INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('6ba7b811-9dad-11d1-80b4-00c04fd430c9', 'Carnicería 3', 37.26693788942789, -6.063505949827319, 4.7, 'Palomares del rio', 'carniceria3.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('6ba7b811-9dad-11d1-80b4-00c04fd430c9', 'CARNECERIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('6ba7b812-9dad-11d1-80b4-00c04fd430c0', 'Carniceria 2', 37.26693788942789, -6.063505949827319, 4.7, 'Palomares del rio', 'carniceria4.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('6ba7b812-9dad-11d1-80b4-00c04fd430c0', 'CARNECERIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'Farmacia', 37.2662548259502, -6.064503731577847, 4.9, 'La puebla del rio', 'farmacia.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'FARMACIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('dee8e900-9dad-11d1-80b4-00c04fd430c9', 'Restaurante ', 37.26473838920224, -6.066084591003926, 4.3, 'La puebla del rio', 'restaurante.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('dee8e900-9dad-11d1-80b4-00c04fd430c9', 'RESTAURANTE');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('efe9e900-9dad-11d1-80b4-00c04fd430c9', 'Bar Pueblo', 37.26461146346672, -6.0604388183971745, 4.2, 'La puebla del rio', 'bar3.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('efe9e900-9dad-11d1-80b4-00c04fd430c9', 'BAR');


INSERT INTO ingredientes(id,name,imagen) VALUES('241149d3-01e0-4ab6-ab80-d5839d08d2dd','queso','queso.jpeg');
INSERT INTO ingredientes(id,name,imagen) VALUES('9dcc75d8-4b5d-4d1f-a4c8-fcae5b85b0ff','bacon','bacon.jpeg');

INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'b714eea5-9b28-4e8c-b189-83d8fc14a834','hamburguesa.jpeg','Hamburguesa');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'550e8400-e29b-41d4-a716-446655440000','manzana.jpeg','Manzana');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61','cocacola.jpeg','CocaCola');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'7b8e6e8d-a202-4927-9bb9-9124a3049c4e','fanta.jpeg','Fanta');
--mas inercciones de productos


INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,2.0,('d1f6a6d4-58c2-45e7-8e74-3d9bafbe75d4'),'pepsi.jpeg','Pepsi');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,4.0,('a3bde4f0-b7c7-4b0a-8f3c-6c6f4b1e8c4b'),'sprite.jpeg','Sprite');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,6.5,('47fa3c1e-93fa-4e3e-a3fc-2f4b1e8d6f8c'),'7Up.jpeg','7Up');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,1.5,('b7a3e4f6-2c3d-4b6e-9a7b-1d3e5f8a9c7d'),'DrPepper.jpeg','DrPepper');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,7.0,('4e5b3c1d-2f8a-4e9c-a3d6-7b4c8e2a9f3b'),'MountainDew.jpeg','MountainDew');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,2.5,('c3d1e2b6-5f8a-4b7e-9c6d-2e4b1f3a7d5c'),'RootBeer.jpeg','RootBeer');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,8.0,('2b7e3c4a-1d6f-4e9b-8a3d-5f2c7b4e9a6f'),'Lemonade.jpeg','Lemonade');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,3.0,('8a3d1b2f-5e4c-4b7e-9f6a-3c2d4e5a1b7f'),'GingerAle.jpeg','GingerAle');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.5,('5f2d3e4a-7b6e-4c9a-8d3b-1e2f7a4b9c6d'),'IceTea.jpeg','IceTea');

INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 7.5, 'd7f8e6c3-8b61-4b4e-8d6e-9b324d791b30', 'pizza.jpeg', 'Pizza');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 3.0, 'e1f3bbf7-2a25-4f5a-8d8d-4e8e9f8b7d36', 'soda.jpeg', 'Soda');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 4.5, '1a3d6d9e-4e3c-4f4a-89e2-7a2a0c3c0f8b', 'hotdog.jpeg', 'Hot Dog');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 6.0, '5c1f8b3d-4f7b-4a8e-88b6-1f3d9e5c8d2b', 'taco.jpeg', 'Taco');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 2.5, '8b3f6e1d-3a7d-4f4c-99b8-5a6e2b7f8c4e', 'fires.jpeg', 'Fries');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 5.0, '9e8d7c6b-3f2a-4d3e-8e7f-4c9b6d2a0f1b', 'nachos.jpeg', 'Nachos');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 3.5, '7b4e6d3f-2c1a-4f4b-9b8e-5d7f1a2c9e8b', 'salad.jpeg', 'Salad');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 6.5, '3a2c7e1d-4f5b-4a8e-9b3d-6e1f2d7c9e4a', 'sanwich.jpeg', 'Sandwich');

INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 10.0, 'fa37dbae-2f0b-4d3e-925a-1b8f9c9c1b2d', 'aspirina.jpeg', 'Aspirina');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 25.0, 'b54f4d0e-1d3e-4f8a-9b0f-2a6f3c7e8b1d', 'vitaminas.jpeg', 'Vitaminas');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 15.0, 'c3e8d4b5-2a3e-4d7b-8c6e-3f2d8e9f7b4e', 'antibiotico.jpeg', 'Antibiótico');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 5.0,  'd7f1c5a2-3b4d-4e8a-9c1d-2e7f8b9c4d5e', 'paracetamol.jpeg', 'Paracetamol');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 12.0, 'e9b2a1c4-4d3e-5f7a-8b6c-1a3d9f2c8e5f', 'ibuprofeno.jpeg', 'Ibuprofeno');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 8.0,  'f2c3d5a6-1e4b-3f8a-9c7e-2d5f6b8a3c4d', 'jarabe.jpeg', 'Jarabe');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 20.0, 'a1d2b3c4-5e6f-4d7a-8b9e-3c4d5e6f7b2a', 'crema.jpeg', 'Crema');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 18.0, 'c8d9e2f1-3a4b-5d7a-8b6e-2f1c3d4e5b6a', 'suero.jpeg', 'Suero');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 6.0,  'd2f3b4a5-4e6d-3f8a-9c7e-5b2d3e1a6c4f', 'antiseptico.jpeg', 'Antiséptico');

INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 15.0, 'a123f6d4-3e2b-4a9c-8d1e-2f6a7b5d8e4c', 'carne.jpeg', 'Carne de Res');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 12.0, 'b5d2f3a7-4b6e-3f9a-8c1d-7e4b2f8a6d3c', 'pollo.jpeg', 'Pollo');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 20.0, 'c6a4d9e8-1f3b-2d7a-9c5e-8a6b1f2e3d4b', 'cerdo.jpeg', 'Cerdo');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 25.0, 'd7c2b3e9-4f5a-3d8b-9c1e-6a5f4d2b3e8a', 'cordero.jpeg', 'Cordero');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 8.0,  'e8b6c1a2-5d3e-4f7a-9b2e-1c3f8d5a7b4d', 'salchicha.jpeg', 'Salchicha');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 10.0, 'f9a5e3b4-6d2b-3f9c-8a1e-2b4d3c5f7e8a', 'tocino.jpeg', 'Tocino');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 18.0, 'a2b7c6e3-1f4d-3a8b-9c2e-5d7a4b1f3e6a', 'chorizo.jpeg', 'Chorizo');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 22.0, 'b3c8a5d4-2e6b-4f9a-8c1d-3f5a6d7e8b4c', 'pavo.jpeg', 'Pavo');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 30.0, 'c4d9e1b6-3f2a-5d7c-8b9e-1a4f6b2e3d8a', 'costillas.jpeg', 'Costillas');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 5.0,  'd5e1b2c8-4a3e-2f9d-8c7b-1f6a3d4e5b7a', 'higado.jpeg', 'Hígado');





INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 12.0, 'f3a6d9e4-2b3e-4a8c-9d1e-7f6b4d2e1a5c', 'ensalada.jpeg', 'Ensalada');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 18.0, 'e5b4c3d6-1a2e-3f7a-8c9b-4d5e2a1f3c7b', 'sopa.jpeg', 'Sopa');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 20.0, 'd6c7a8e5-4b3f-2d9a-8c1e-5f7a4e3b2c9d', 'pasta.jpeg', 'Pasta');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 25.0, 'c9e1b5d4-6f3a-4d8b-9c2e-7a5f1d4b6e3a', 'steak.jpeg', 'Steak');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 22.0, 'f8c5a4e1-3d6b-4f9a-8c7e-1b2e3a5d7c4f', 'paella.jpeg', 'Paella');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 8.0,  'e1b4d6c3-5a7f-3d8a-9c1e-4f2b3d6e1a5c', 'hamburguesa.jpeg', 'Hamburguesa');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 30.0, 'd3c2a8e5-1b6f-4d9a-8c1e-5f7b4e2d6a3b', 'marisco.jpeg', 'Mariscos');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 6.0,  'c6d9b4e2-2a3e-5d7a-8c1e-1f4b5a7e3c9d', 'postre.jpeg', 'Postre');

INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 35.0, 'a1f2d3e4-5b6c-7d8e-9f1a-2b3c4d5e6f7a', 'camiseta.jpeg', 'Camiseta');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 50.0, 'b2d3f4a5-6c7d-8e9f-1a2b-3c4d5e6f7a8b', 'pantalones.jpeg', 'Pantalones');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 25.0, 'c3e4a5b6-7d8e-9f1a-2b3c-4d5e6f7a8b9c', 'camisa.jpeg', 'Camisa');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 60.0, 'd4f5b6c7-8e9f-1a2b-3c4d-5e6f7a8b9c1d', 'chaqueta.jpeg', 'Chaqueta');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 45.0, 'e5a6b7c8-9f1a-2b3c-4d5e-6f7a8b9c1d2e', 'zapatos.jpeg', 'Zapatos');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 20.0, 'f6b7c8d9-1a2b-3c4d-5e6f-7a8b9c1d2e3f', 'sombrero.jpeg', 'Sombrero');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 55.0, 'a7c8d9e1-2b3c-4d5e-6f7a-8b9c1d2e3f4a', 'abrigo.jpeg', 'Abrigo');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 30.0, 'b8d9e1f2-3c4d-5e6f-7a8b-9c1d2e3f4a5b', 'falda.jpeg', 'Falda');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 40.0, 'c9e1f2a3-4d5e-6f7a-8b9c-1d2e3f4a5b6c', 'vestido.jpeg', 'Vestido');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 28.0, 'd1f2a3b4-5e6f-7a8b-9c1d-2e3f4a5b6c7d', 'bufanda.jpeg', 'Bufanda');

INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 35.0, '4e6f7a8b-9c1d-2e3f-4a5b-6c7d8e9f1a2b', 'camiseta.jpeg', 'Camiseta');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 50.0, '5e6f7a8b-9c1d-2e3f-4a5b-6c7d8e9f1a2b', 'pantalones.jpeg', 'Pantalones');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 25.0, '6e7f8a9b-0c1d-2e3f-4a5b-6c7d8e9f1a2b', 'camisa.jpeg', 'Camisa');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 60.0, '7e8f9a0b-1c2d-3e4f-5a6b-7c8d9e0f1a2b', 'chaqueta.jpeg', 'Chaqueta');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 45.0, '8e9f0a1b-2c3d-4e5f-6a7b-8c9d0e1f2a3b', 'zapatos.jpeg', 'Zapatos');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 20.0, '9e0f1a2b-3c4d-5e6f-7a8b-9c0d1e2f3a4b', 'sombrero.jpeg', 'Sombrero');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 55.0, '0e1f2a3b-4c5d-6e7f-8a9b-0c1d2e3f4a5b', 'abrigo.jpeg', 'Abrigo');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 30.0, '1e2f3a4b-5c6d-7e8f-9a0b-1c2d3e4f5a6b', 'falda.jpeg', 'Falda');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 40.0, '2e3f4a5b-6c7d-8e9f-0a1b-2c3d4e5f6a7b', 'vestido.jpeg', 'Vestido');
INSERT INTO producto(disponible, precio, id, imagen, name) VALUES (true, 28.0, '3e4f5a6b-7c8d-9e0f-1a2b-3c4d5e6f7a8b', 'bufanda.jpeg', 'Bufanda');








INSERT INTO producto_ingredientes(ingredientes_id,producto_id) VALUES ('241149d3-01e0-4ab6-ab80-d5839d08d2dd','b714eea5-9b28-4e8c-b189-83d8fc14a834');
INSERT INTO producto_ingredientes(ingredientes_id,producto_id) VALUES ('9dcc75d8-4b5d-4d1f-a4c8-fcae5b85b0ff','b714eea5-9b28-4e8c-b189-83d8fc14a834');



INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen,likes) VALUES ('ffeae900-9dad-11d1-80b4-00c04fd430c9', 'Cafeteria ', 37.26320511204529, -6.063870937788194, 4.6, 'La puebla del rio', 'bar2.jpeg',false);
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('ffeae900-9dad-11d1-80b4-00c04fd430c9', 'BAR');

--insercciones de comercios a productos

INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','b714eea5-9b28-4e8c-b189-83d8fc14a834');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','d1f6a6d4-58c2-45e7-8e74-3d9bafbe75d4');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','a3bde4f0-b7c7-4b0a-8f3c-6c6f4b1e8c4b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','47fa3c1e-93fa-4e3e-a3fc-2f4b1e8d6f8c');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','b7a3e4f6-2c3d-4b6e-9a7b-1d3e5f8a9c7d');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','4e5b3c1d-2f8a-4e9c-a3d6-7b4c8e2a9f3b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','c3d1e2b6-5f8a-4b7e-9c6d-2e4b1f3a7d5c');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','2b7e3c4a-1d6f-4e9b-8a3d-5f2c7b4e9a6f');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','8a3d1b2f-5e4c-4b7e-9f6a-3c2d4e5a1b7f');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9','5f2d3e4a-7b6e-4c9a-8d3b-1e2f7a4b9c6d');


INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'd7f8e6c3-8b61-4b4e-8d6e-9b324d791b30');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'e1f3bbf7-2a25-4f5a-8d8d-4e8e9f8b7d36');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', '1a3d6d9e-4e3c-4f4a-89e2-7a2a0c3c0f8b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', '5c1f8b3d-4f7b-4a8e-88b6-1f3d9e5c8d2b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', '8b3f6e1d-3a7d-4f4c-99b8-5a6e2b7f8c4e');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', '9e8d7c6b-3f2a-4d3e-8e7f-4c9b6d2a0f1b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', '7b4e6d3f-2c1a-4f4b-9b8e-5d7f1a2c9e8b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', '3a2c7e1d-4f5b-4a8e-9b3d-6e1f2d7c9e4a');

INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'fa37dbae-2f0b-4d3e-925a-1b8f9c9c1b2d');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'b54f4d0e-1d3e-4f8a-9b0f-2a6f3c7e8b1d');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'c3e8d4b5-2a3e-4d7b-8c6e-3f2d8e9f7b4e');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'd7f1c5a2-3b4d-4e8a-9c1d-2e7f8b9c4d5e');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'e9b2a1c4-4d3e-5f7a-8b6c-1a3d9f2c8e5f');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'f2c3d5a6-1e4b-3f8a-9c7e-2d5f6b8a3c4d');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'a1d2b3c4-5e6f-4d7a-8b9e-3c4d5e6f7b2a');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'c8d9e2f1-3a4b-5d7a-8b6e-2f1c3d4e5b6a');

INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('123e4567-e89b-12d3-a456-426614174000', 'a123f6d4-3e2b-4a9c-8d1e-2f6a7b5d8e4c');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('123e4567-e89b-12d3-a456-426614174000', 'b5d2f3a7-4b6e-3f9a-8c1d-7e4b2f8a6d3c');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('123e4567-e89b-12d3-a456-426614174000', 'c6a4d9e8-1f3b-2d7a-9c5e-8a6b1f2e3d4b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('123e4567-e89b-12d3-a456-426614174000', 'd7c2b3e9-4f5a-3d8b-9c1e-6a5f4d2b3e8a');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('123e4567-e89b-12d3-a456-426614174000', 'e8b6c1a2-5d3e-4f7a-9b2e-1c3f8d5a7b4d');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('123e4567-e89b-12d3-a456-426614174000', 'f9a5e3b4-6d2b-3f9c-8a1e-2b4d3c5f7e8a');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('123e4567-e89b-12d3-a456-426614174000', 'a2b7c6e3-1f4d-3a8b-9c2e-5d7a4b1f3e6a');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('123e4567-e89b-12d3-a456-426614174000', 'b3c8a5d4-2e6b-4f9a-8c1d-3f5a6d7e8b4c');



INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'f3a6d9e4-2b3e-4a8c-9d1e-7f6b4d2e1a5c');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'e5b4c3d6-1a2e-3f7a-8c9b-4d5e2a1f3c7b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'd6c7a8e5-4b3f-2d9a-8c1e-5f7a4e3b2c9d');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'c9e1b5d4-6f3a-4d8b-9c2e-7a5f1d4b6e3a');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'f8c5a4e1-3d6b-4f9a-8c7e-1b2e3a5d7c4f');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'e1b4d6c3-5a7f-3d8a-9c1e-4f2b3d6e1a5c');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'd3c2a8e5-1b6f-4d9a-8c1e-5f7b4e2d6a3b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'c6d9b4e2-2a3e-5d7a-8c1e-1f4b5a7e3c9d');

INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'a1f2d3e4-5b6c-7d8e-9f1a-2b3c4d5e6f7a');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'b2d3f4a5-6c7d-8e9f-1a2b-3c4d5e6f7a8b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'c3e4a5b6-7d8e-9f1a-2b3c-4d5e6f7a8b9c');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'd4f5b6c7-8e9f-1a2b-3c4d-5e6f7a8b9c1d');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'e5a6b7c8-9f1a-2b3c-4d5e-6f7a8b9c1d2e');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'f6b7c8d9-1a2b-3c4d-5e6f-7a8b9c1d2e3f');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'a7c8d9e1-2b3c-4d5e-6f7a-8b9c1d2e3f4a');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'b8d9e1f2-3c4d-5e6f-7a8b-9c1d2e3f4a5b');

INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', '4e6f7a8b-9c1d-2e3f-4a5b-6c7d8e9f1a2b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', '5e6f7a8b-9c1d-2e3f-4a5b-6c7d8e9f1a2b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', '6e7f8a9b-0c1d-2e3f-4a5b-6c7d8e9f1a2b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', '7e8f9a0b-1c2d-3e4f-5a6b-7c8d9e0f1a2b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', '8e9f0a1b-2c3d-4e5f-6a7b-8c9d0e1f2a3b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', '9e0f1a2b-3c4d-5e6f-7a8b-9c0d1e2f3a4b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', '0e1f2a3b-4c5d-6e7f-8a9b-0c1d2e3f4a5b');
INSERT INTO comercio_productos(comercio_id,productos_id) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', '1e2f3a4b-5c6d-7e8f-9a0b-1c2d3e4f5a6b');



INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('f89f898a-70aa-48d5-8088-3f3c892d7bae','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('f89f898a-70aa-48d5-8088-3f3c892d7bae','550e8400-e29b-41d4-a716-446655440000');
INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9','7b8e6e8d-a202-4927-9bb9-9124a3049c4e');
INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9','3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61');

INSERT INTO favorito (comercio_id, usuario_id) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9', '5d818565-99f9-4d80-920e-8259c6ecb8e6');




--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('123e4567-e89b-12d3-a456-426614174000','b714eea5-9b28-4e8c-b189-83d8fc14a834');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('123e4567-e89b-12d3-a456-426614174000','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('123e4567-e89b-12d3-a456-426614174000','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('123e4567-e89b-12d3-a456-426614174000','3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61');

--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('7bb2e900-9dad-11d1-80b4-00c04fd430c9','b714eea5-9b28-4e8c-b189-83d8fc14a834');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('7bb2e900-9dad-11d1-80b4-00c04fd430c9','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('7bb2e900-9dad-11d1-80b4-00c04fd430c9','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('7bb2e900-9dad-11d1-80b4-00c04fd430c9','3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61');

--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('8cc3e900-9dad-11d1-80b4-00c04fd430c9','b714eea5-9b28-4e8c-b189-83d8fc14a834');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('8cc3e900-9dad-11d1-80b4-00c04fd430c9','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('8cc3e900-9dad-11d1-80b4-00c04fd430c9','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('8cc3e900-9dad-11d1-80b4-00c04fd430c9','3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61');

--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('bee6e900-9dad-11d1-80b4-00c04fd430c9','b714eea5-9b28-4e8c-b189-83d8fc14a834');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('bee6e900-9dad-11d1-80b4-00c04fd430c9','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('bee6e900-9dad-11d1-80b4-00c04fd430c9','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('bee6e900-9dad-11d1-80b4-00c04fd430c9','3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61');

--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('cee7e900-9dad-11d1-80b4-00c04fd430c9','b714eea5-9b28-4e8c-b189-83d8fc14a834');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('cee7e900-9dad-11d1-80b4-00c04fd430c9','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('cee7e900-9dad-11d1-80b4-00c04fd430c9','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('cee7e900-9dad-11d1-80b4-00c04fd430c9','3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61');

