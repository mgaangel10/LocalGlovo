

DELETE FROM producto_ingredientes;
INSERT INTO usuario (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled,foto_url) VALUES ('5d818565-99f9-4d80-920e-8259c6ecb8e6', 'Pedro','pepe', 'ToRechulon', 'pedro@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQciKN1y59CDYMq-IALg7OUijN7hIiM8hdzKw&usqp=CAU');
INSERT INTO usuario_roles ( roles,usuario_id) VALUES (0,'5d818565-99f9-4d80-920e-8259c6ecb8e6');
INSERT INTO administrador (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled,foto_url) VALUES ('a23c61eb-4a5a-4cdd-beea-44234583ff4c', 'Angel','perez', 'ToRechulon', 'angel@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true,'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQciKN1y59CDYMq-IALg7OUijN7hIiM8hdzKw&usqp=CAU');
INSERT INTO administrador_roles ( roles,administrador_id) VALUES (1,'a23c61eb-4a5a-4cdd-beea-44234583ff4c');
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction,imagen)VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'Las Lozas', 37.2700843067059, -6.063028856447782, 4.8, 'La puebla del rio','https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction,imagen)VALUES ('123e4567-e89b-12d3-a456-426614174000', 'Felipon', 37.27203372064043, -6.066180282066359, 4.8, 'La puebla del rio','https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id,categorias)VALUES('f89f898a-70aa-48d5-8088-3f3c892d7bae','FARMACIA');
INSERT INTO comercio_categorias(comercio_id,categorias)VALUES('123e4567-e89b-12d3-a456-426614174000','CARNECERIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda Bendicion', 37.272149626637564, -6.06192884623146, 4.5, 'La puebla del rio', 'https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('7bb2e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDAROPA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'Bar Osso', 37.272804495539006, -6.062129797459527, 4.2, 'La puebla del rio', 'https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'BAR');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda G Fashion', 37.2708028410246, -6.06328770833118, 4.1, 'Sevilla', 'https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDAROPA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9', 'Supermercado', 37.268698190432744, -6.065863976966079, 4.6, 'Coria del Rio', 'https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDACOMESTIBLES');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('bee6e900-9dad-11d1-80b4-00c04fd430c9', 'Carnicería', 37.26693788942789, -6.063505949827319, 4.7, 'Palomares del rio', 'https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('bee6e900-9dad-11d1-80b4-00c04fd430c9', 'CARNECERIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'Pet shop', 37.2662548259502, -6.064503731577847, 4.9, 'La puebla del rio', 'https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'FARMACIA');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('dee8e900-9dad-11d1-80b4-00c04fd430c9', 'Restaurante', 37.26473838920224, -6.066084591003926, 4.3, 'La puebla del rio', 'https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('dee8e900-9dad-11d1-80b4-00c04fd430c9', 'RESTAURANTE');


INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('efe9e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda SportMax', 37.26461146346672, -6.0604388183971745, 4.2, 'La puebla del rio', 'https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('efe9e900-9dad-11d1-80b4-00c04fd430c9', 'BAR');


INSERT INTO ingredientes(id,name,imagen) VALUES('241149d3-01e0-4ab6-ab80-d5839d08d2dd','queso','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-aJrV-c_wMpQuZd9CGVpTmGIxYsBBSD5Y9w&usqp=CAU');
INSERT INTO ingredientes(id,name,imagen) VALUES('9dcc75d8-4b5d-4d1f-a4c8-fcae5b85b0ff','bacon','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToq2hM1WG_DfqtcNXFQitF0uYK7QlH22b7wg&usqp=CAU');

INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'b714eea5-9b28-4e8c-b189-83d8fc14a834','https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7','Hamburguesa');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'550e8400-e29b-41d4-a716-446655440000','https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7','Manzana');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'3f33b5a5-bc9a-4b4c-9d6f-0935379d7e61','https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7','CocaCola');
INSERT INTO producto(disponible,precio,id,imagen,name) VALUES (true,5.0,'7b8e6e8d-a202-4927-9bb9-9124a3049c4e','https://th.bing.com/th/id/OIP.xpHtN8nOMEDD69KJLoiHDAHaHa?w=177&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7','Fanta');


INSERT INTO producto_ingredientes(ingredientes_id,producto_id) VALUES ('241149d3-01e0-4ab6-ab80-d5839d08d2dd','b714eea5-9b28-4e8c-b189-83d8fc14a834');
INSERT INTO producto_ingredientes(ingredientes_id,producto_id) VALUES ('9dcc75d8-4b5d-4d1f-a4c8-fcae5b85b0ff','b714eea5-9b28-4e8c-b189-83d8fc14a834');



INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('ffeae900-9dad-11d1-80b4-00c04fd430c9', 'Cafetería ', 37.26320511204529, -6.063870937788194, 4.6, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.EK3cUr1Ocrap5-a7LdHP_AHaE7?rs=1&pid=ImgDetMain');
INSERT INTO comercio_productos(comercio_id,productos_id)VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9','b714eea5-9b28-4e8c-b189-83d8fc14a834');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('ffeae900-9dad-11d1-80b4-00c04fd430c9', 'BAR');

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

