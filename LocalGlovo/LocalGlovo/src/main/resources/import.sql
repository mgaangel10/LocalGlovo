


INSERT INTO usuario (id, name,last_name, username, email, password,phone_number,ACCOUNT_NON_EXPIRED,ACCOUNT_NON_LOCKED,CREDENTIALS_NON_EXPIRED,enabled) VALUES ('5d818565-99f9-4d80-920e-8259c6ecb8e6', 'Pedro','pepe', 'ToRechulon', 'pedro@gmail.com', '{bcrypt}$2a$10$05HASeZdtwl8NS/nWbNMJOU07tiGZ9Z/mVE2Z.FKhsyjkCK7yuLqa',383838,true,true,true,true);
INSERT INTO usuario_roles ( roles,usuario_id) VALUES (0,'5d818565-99f9-4d80-920e-8259c6ecb8e6');
INSERT INTO comercio (id, name, latitud, longitud, rating, name_direction,imagen)VALUES ('f89f898a-70aa-48d5-8088-3f3c892d7bae', 'Las Lozas', '1233232', '232121', 4.8, 'La puebla del rio','https://lh5.googleusercontent.com/p/AF1QipM77k8VJggh1IVj0goQEB17nnwn3RFpKd_HQPFv=w426-h240-k-no');
INSERT INTO comercio_categorias(comercio_id,categorias)VALUES('f89f898a-70aa-48d5-8088-3f3c892d7bae','FARMACIA');