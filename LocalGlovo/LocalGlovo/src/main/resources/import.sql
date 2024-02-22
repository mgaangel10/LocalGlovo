


INSERT INTO usuario (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled) VALUES ('5d818565-99f9-4d80-920e-8259c6ecb8e6', 'Pedro','pepe', 'ToRechulon', 'pedro@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true);
INSERT INTO usuario_roles ( roles,usuario_id) VALUES (0,'5d818565-99f9-4d80-920e-8259c6ecb8e6');
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction,imagen)VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'Las Lozas', '1233232', '232121', 4.8, 'La puebla del rio','https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction,imagen)VALUES ('123e4567-e89b-12d3-a456-426614174000', 'Felipon', '1233232', '232121', 4.8, 'La puebla del rio','https://carniceriafelipon.com/wp-content/uploads/2021/03/logo-felipon-vitola-300x165.png');
INSERT INTO comercio_categorias(comercio_id,categorias)VALUES('f89f898a-70aa-48d5-8088-3f3c892d7bae','FARMACIA');
INSERT INTO comercio_categorias(comercio_id,categorias)VALUES('123e4567-e89b-12d3-a456-426614174000','CARNECERIA');

-- Comercio 3
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('7bb2e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda Bendicion', '1233232', '232121', 4.5, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.FAoaIFM_o4OA5Z796VeQgAHaE7?rs=1&pid=ImgDetMain');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('7bb2e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDAROPA');

-- Comercio 4
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'Bar Osso', '1233232', '232121', 4.2, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.q8bsdXqb7JaGwRQL3IdixQHaE6?rs=1&pid=ImgDetMain');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('8cc3e900-9dad-11d1-80b4-00c04fd430c9', 'BAR');

-- Comercio 5
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda G Fashion', '1233232', '232121', 4.1, 'La puebla del rio', 'https://th.bing.com/th/id/R.cc44aae1b636de950d1eabdbd54e7d8e?rik=9h9WTyGMc8rX%2fA&pid=ImgRaw&r=0');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('9dd4e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDAROPA');

-- Comercio 6
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('aee5e900-9dad-11d1-80b4-00c04fd430c9', 'Supermercado ', '1233232', '232121', 4.6, 'La puebla del rio', 'https://th.bing.com/th/id/R.d4f95caf13f52053fbc56bc894b80c56?rik=AuUIDnCnFmZozA&pid=ImgRaw&r=0');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('aee5e900-9dad-11d1-80b4-00c04fd430c9', 'TIENDACOMESTIBLES');

-- Comercio 7
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('bee6e900-9dad-11d1-80b4-00c04fd430c9', 'Carnicería ', '1233232', '232121', 4.7, 'La puebla del rio', 'https://th.bing.com/th/id/R.bf36c3fb96e08014651b7fb3dc3a9752?rik=3JY%2fDpfFi6leIw&pid=ImgRaw&r=0');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('bee6e900-9dad-11d1-80b4-00c04fd430c9', 'CARNECERIA');

-- Comercio 8
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'Pet shop', '1233232', '232121', 4.9, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.qKIl_MfRoNu5UiO5hXlKMgHaEj?rs=1&pid=ImgDetMain');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('cee7e900-9dad-11d1-80b4-00c04fd430c9', 'FARMACIA');

-- Comercio 9
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('dee8e900-9dad-11d1-80b4-00c04fd430c9', 'Restaurante ', '1233232', '232121', 4.3, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.jVBnWhRWpzEZ3PNmVsNdVwHaE7?rs=1&pid=ImgDetMain');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('dee8e900-9dad-11d1-80b4-00c04fd430c9', 'RESTAURANTE');

-- Comercio 10
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('efe9e900-9dad-11d1-80b4-00c04fd430c9', 'Tienda SportMax', '1233232', '232121', 4.2, 'La puebla del rio', 'https://www.archisearch.gr/wp-content/uploads/old-site/550234-497865010257186-1736547832-n.jpg');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('efe9e900-9dad-11d1-80b4-00c04fd430c9', 'BAR');

-- Comercio 11
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction, imagen) VALUES ('ffeae900-9dad-11d1-80b4-00c04fd430c9', 'Cafetería ', '1233232', '232121', 4.6, 'La puebla del rio', 'https://th.bing.com/th/id/OIP.EK3cUr1Ocrap5-a7LdHP_AHaE7?rs=1&pid=ImgDetMain');
INSERT INTO comercio_categorias(comercio_id, categorias) VALUES('ffeae900-9dad-11d1-80b4-00c04fd430c9', 'BAR');
