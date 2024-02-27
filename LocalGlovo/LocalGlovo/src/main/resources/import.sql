

DELETE FROM producto_ingredientes;
INSERT INTO usuario (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled) VALUES ('5d818565-99f9-4d80-920e-8259c6ecb8e6', 'Pedro','pepe', 'ToRechulon', 'pedro@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true);
INSERT INTO usuario_roles ( roles,usuario_id) VALUES (0,'5d818565-99f9-4d80-920e-8259c6ecb8e6');
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction,imagen)VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'Las Lozas', '1233232', '232121', 4.8, 'La puebla del rio','https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction,imagen)VALUES ('123e4567-e89b-12d3-a456-426614174000', 'Felipon', '1233232', '232121', 4.8, 'La puebla del rio','');
INSERT INTO comercio_categorias(comercio_id,categorias)VALUES('f89f898a-70aa-48d5-8088-3f3c892d7bae','FARMACIA');
INSERT INTO comercio_categorias(comercio_id,categorias)VALUES('123e4567-e89b-12d3-a456-426614174000','CARNECERIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda Bendicion', '1233232', '232121', 4.5, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.FAoaIFM_o4OA5Z796VeQgAHaE7?rs=1&pid=ImgDetMain');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('7bb2e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDAROPA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'Bar Osso', '1233232', '232121', 4.2, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.q8bsdXqb7JaGwRQL3IdixQHaE6?rs=1&pid=ImgDetMain');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'BAR');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda G Fashion', '1233232', '232121', 4.1, 'La puebla del rio', 'https://th.bing.com/th/id/R.cc44aae1b636de950d1eabdbd54e7d8e?rik=9h9WTyGMc8rX%2fA&pid=ImgRaw&r=0');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDAROPA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9', 'Supermercado ', '1233232', '232121', 4.6, 'La puebla del rio', 'https://th.bing.com/th/id/R.d4f95caf13f52053fbc56bc894b80c56?rik=AuUIDnCnFmZozA&pid=ImgRaw&r=0');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDACOMESTIBLES');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('bee6e900-9dad-11d1-80b4-00c04fd430c9', 'Carnicería ', '1233232', '232121', 4.7, 'La puebla del rio', 'https://th.bing.com/th/id/R.bf36c3fb96e08014651b7fb3dc3a9752?rik=3JY%2fDpfFi6leIw&pid=ImgRaw&r=0');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('bee6e900-9dad-11d1-80b4-00c04fd430c9', 'CARNECERIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'Pet shop', '1233232', '232121', 4.9, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.qKIl_MfRoNu5UiO5hXlKMgHaEj?rs=1&pid=ImgDetMain');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'FARMACIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('dee8e900-9dad-11d1-80b4-00c04fd430c9', 'Restaurante ', '1233232', '232121', 4.3, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.jVBnWhRWpzEZ3PNmVsNdVwHaE7?rs=1&pid=ImgDetMain');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('dee8e900-9dad-11d1-80b4-00c04fd430c9', 'RESTAURANTE');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('efe9e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda SportMax', '1233232', '232121', 4.2, 'La puebla del rio', '');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('efe9e900-9dad-11d1-80b4-00c04fd430c9', 'BAR');


INSERT INTO ingredientes(id,name) VALUES('241149d3-01e0-4ab6-ab80-d5839d08d2dd','queso');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'b714eea5-9b28-4e8c-b189-83d8fc14a834','https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7','Hamburguesa');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'550e8400-e29b-41d4-a716-446655440000','https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7','Manzana');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61','https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7','CocaCola');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'7b8e6e8d-a202-4927-9bb9-9124a3049c4e','https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7','Fanta');
INSERT INTO producto_ingredientes(ingredientes_id,producto_id) VALUES ('241149d3-01e0-4ab6-ab80-d5839d08d2dd','b714eea5-9b28-4e8c-b189-83d8fc14a834');



INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('ffeae900-9dad-11d1-80b4-00c04fd430c9', 'Cafetería ', '1233232', '232121', 4.6, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.EK3cUr1Ocrap5-a7LdHP_AHaE7?rs=1&pid=ImgDetMain');
INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9','b714eea5-9b28-4e8c-b189-83d8fc14a834');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('ffeae900-9dad-11d1-80b4-00c04fd430c9', 'BAR');

INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('f89f898a-70aa-48d5-8088-3f3c892d7bae','550e8400-e29b-41d4-a716-446655440000');
--INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('f89f898a-70aa-48d5-8088-3f3c892d7bae','550e8400-e29b-41d4-a716-446655440000');
INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9','7b8e6e8d-a202-4927-9bb9-9124a3049c4e');
INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9','3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61');

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

