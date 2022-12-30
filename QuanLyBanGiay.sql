create table account(
	accID int auto_increment,
    userName nvarchar(50) not null unique,
    pass nvarchar(50) not null,
    isSell int,
    isAdmin int,
    email nvarchar(100) not null unique,
    constraint PK_account primary key(accID)
    );


create table category(
	cateID int auto_increment,
    cateName nvarchar(50),
    constraint PK_category primary key(cateID)
    );
    
create table product(
	productID int auto_increment,
    productName nvarchar(50),
    price int,
    cateID int,
	constraint FK_ProductCategory foreign key (cateID) references category(cateID),
    constraint PK_product primary key(productID),
    description nvarchar(300),
    image text
    ); 
    
create table cart(
	cartID int auto_increment,
    accID int,
	productID int,
    ammount int,
    size nvarchar(50),
    constraint PK_cart primary key(cartID),
	constraint FK_CartAccount foreign key(accID) references account(accID),
    constraint FK_CartProduct foreign key(productID) references product(productID)
    );

create table review(
	reviewID int auto_increment,
	accID int,
    productID int,
    contentReview nvarchar(500),
    dateReview date,
    constraint PK_review primary key(reviewID),
    constraint FK_review_account foreign key(accID) references account(accID),
    constraint FK_review_product foreign key(productID) references product(productID)
    );
    
create table invoice(
	invoiceID int auto_increment,
    accID int,
    total int,
    create_date datetime,
    constraint PK_invoice primary key(invoiceID),
    constraint FK_invoice_account foreign key(accID) references account(accID)
    );
    
create table invoiceDetail(
	invoiceID int,
    productID int,
	ammount int,
    constraint FK_invoiceDetail_product foreign key(productID) references product(productID),
    constraint FK_invoiceDetail_invoice foreign key(invoiceID) references invoice(invoiceID)
    );
    
create table shippingDetail(
	shipID int auto_increment,
    invoiceID int,
    city nvarchar(50),
    firstName nvarchar(50),
    lastName nvarchar(50),
    address nvarchar(200),
    state nvarchar(50),
    zip nvarchar(50),
    email nvarchar(50),
    phone nvarchar(50),
    constraint PK_shippingDetail primary key(shipID),
    constraint FK_shippingDetail foreign key(invoiceID) references invoice(invoiceID)
    );
    
create table SoLuongDaBan(
	productID int,
    sold int default 0,
    constraint FK_SoLuongDaBan_product foreign key(productID) references product(productID)
    on delete cascade
);

delimiter $$
create trigger tg_insertSLdaban after insert on product
for each row
begin
insert into SoLuongDaBan(productID, sold) values(new.productID, default);
end$$
delimiter ;
    
	insert into account (userName, pass, isSell, isAdmin, email) values('khanh1307', '1234', 0, 0, 'haxagi1307@gmail.com');
	insert into account (userName, pass, isSell, isAdmin, email) values('khanh1234', '1234', 0, 0, 'haxigi1307@gmail.com');
    
	insert into category (cateName) values('Giay Nike');
    insert into category (cateName) values('Giay Adidas');
    insert into category (cateName) values('Giay Converse');
    insert into category (cateName) values('Giay Puma');
    
	insert into product (productName, price, cateID, description, image) values ('Nike Epic React', 500, 1, 'Since the original model, the Nike Epic React has been released in various materials and color schemes. Running is your daily ritual, with every step taking you closer to your personal goal.','https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/gorfwjchoasrrzr1fggt/air-max-270-shoes-2V5C4p.png');
    insert into product (productName, price, cateID, description, image) values ('Nike Air Zoom Pegasus', 100, 1, 'Running is your daily ritual, with every step taking you closer to your personal goal. Let the Nike Air Zoom Pegasus help you ascend to new heights','https://static.nike.com/a/images/t_default/57dd56da-b069-4c63-bece-4810c1067215/air-zoom-pegasus-39-road-running-shoes-kmZSD6.png');
    insert into product (productName, price, cateID, description, image) values ('Nike Air Max Zero', 300, 1, 'Inspired by Mictlán, this is a story of family connections. This unique "Día de Muertos" version of the Air Jordan.','https://static.nike.com/a/images/t_default/45c6eafe-3494-4b5c-b5af-9a827c562917/air-max-flyknit-racer-shoes-Q9lN71.png');
	insert into product (productName, price, cateID, description, image) values ('Nike Air Max 270', 500, 1,'Nike is first lifestyle Air Max brings you style, comfort and big attitude in the Nike Air Max 270. ', 'https://static.nike.com/a/images/t_default/2ae01600-19b1-4d59-a541-d5bb68af8460/air-max-270-mens-shoes-KkLcGR.png');
    insert into product (productName, price, cateID, description, image) values ('Nike Air Max 280', 100, 1, 'The Nike Air Max 280 was released in 1982, and they were the first basketball shoe to feature Nike Air cushioning. ','https://static.nike.com/a/images/t_default/21d72272-b29c-4827-9394-78219911c9e1/air-max-270-womens-shoes-Pgb94t.png');
    insert into product (productName, price, cateID, description, image) values ('Nike Air Max 290', 300, 1, 'Nike debuted the Air Max 290 in 1985 and made it one of the most iconic Nike models ever produced. The Air Max 290 was designed to offer maximum comfort with a lightweight, breathable upper.','https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/11cd6eeb-0966-48b0-8c18-2c0567453603/air-max-2021-se-shoes-ncvjbx.png');
	insert into product (productName, price, cateID, description, image) values ('Nike Angel', 500, 1, 'Nike React shoes are designed for quick acceleration and lightweight cushioning. In addition, they feature a Zoom Air heel unit designed to maximize forefoot support','https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/cab65c24-4e05-4218-819f-11c3b171c263/air-max-95-se-shoe-1swxxQ.png');
    insert into product (productName, price, cateID, description, image) values ('Nike Air Lucifer', 100, 1, 'The Nike Air Lucifer is a classic. They were created in 1972. Since then, pretty much every celebrity has worn the Lucifer at some point or another. ','https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/b23fdfae-22d3-4323-9f90-f23cae82fed3/air-max-bolt-womens-shoes-WSLhlr.png');

	insert into product (productName, price, cateID, description, image) values ('Adidas Ultraboost', 200, 2, 'With this shoe, you really can put in the miles as the supportive plush boot midsole returns energy back to you, the runner, with every step you take.','https://kingshoes.vn/data/upload/media/gia%CC%80y-adidas-forum-fy7756-chi%CC%81nh-ha%CC%83ng-de%CC%82%CC%81n-king-shoes-1.jpg');
    insert into product (productName, price, cateID, description, image) values ('ADIDAS SUPER COURT', 400, 2, 'Great gifts for sneakerheads or any man or woman on your list, ahead are the best Adidas sneakers to shop for loved ones and/or yourself this season','https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/61f87dec481e4512823ea7fb0080ba1a_9366/Giay_Gazelle_DJen_BB5476_01_standard.jpg');
    insert into product (productName, price, cateID, description, image) values ('Adidas Edge', 600, 2, 'The Adidas Edge shoes harness this same technology in the 3D-printed heel cradle designed to guide the foot forward and absorb impact.','https://assets.adidas.com/images/h_840,f_auto,q_auto,fl_lossy,c_fill,g_auto/c3bd9dda9fdd4a7cbc9aad1e00dd0045_9366/NMD_R1_Primeblue_Shoes_White_GZ9260_01_standard.jpg');
	insert into product (productName, price, cateID, description, image) values ('Adidas NMD V1', 200, 2, 'The NMD V1 Adidas embodies ultimate simplicity with its clean nubuck upper and contrasting Three Stripes design. ','https://assets.adidas.com/images/w_383,h_383,f_auto,q_auto,fl_lossy,c_fill,g_auto/c749da4cca604fb29519ae5200dca2d0_9366/nmd_v3-shoes.jpg');
    insert into product (productName, price, cateID, description, image) values ('ADIDAS 360', 400, 2, 'The Adidas 360 Shoe remains a timeless icon thanks to its simple low-cut leather upper with the unmistakable Three Stripes branding emblazoned on the side','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTPQRSstp05QAfznvnpihySIhDrZ1HkuS3EQQCk1PO68BXGfEjmpq6mvelgXszHu_f9BXA&usqp=CAU');
    insert into product (productName, price, cateID, description, image) values ('Adidas Mirror', 600, 2, 'The Adidas Mirror has added its creative direction to Pumas Nitefox silhouette. It is a solid chunky sneaker, bright enough for a late summer rotation.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhMRQpKlvG9pDTCVyIVIYyViuuXlopTb2nCROhXQxNnx9pxvWy_b-C3SG3J4v5Cw7rStU&usqp=CAU');
	insert into product (productName, price, cateID, description, image) values ('Adidas NMD V3', 200, 2, 'The Adidas NMD V3 speaking of Slipstream colorways, the white on red is a classic pairing that will go with just about any fit.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpukiHGR_jTPmpyN9_suIuKzUBh1GrB69xNzk_NVCGrQo9OOBF2X56bR_ZXhPRyd3r51E&usqp=CAU');
    insert into product (productName, price, cateID, description, image) values ('ADIDAS NMD V2', 400, 2, 'The Adidas NMD V2 technology but in low-maintenance black on black? Take my money. I feel batman would wear these if he had the time to be a sneakerhead.','https://i.ebayimg.com/thumbs/images/g/TpIAAOSw2eFi~epw/s-l1600.jpg');
    
    insert into product (productName, price, cateID, description, image) values ('Puma Wild Rider', 400, 4, 'Streamlined and futuristic, it only makes sense to top off the list with one of our favorites.','https://images.puma.com/image/upload/f_auto,q_auto,b_rgb:fafafa,w_450,h_450/global/377180/01/sv01/fnd/IND/fmt/png');
    insert into product (productName, price, cateID, description, image) values ('Puma Future Rider', 500, 4, 'This is one of the colorways that will help you easily transition into the Fall. The sneaker is the brainchild of two sportswear titans.','https://bizweb.dktcdn.net/thumb/large/100/427/145/products/383926-02-1-1800x1800.jpg?v=1661412703000');
    insert into product (productName, price, cateID, description, image) values ('Puma Cali Dream', 600, 4, 'The Brooklyn studio has added its creative direction to Pumas Nitefox silhouette. It is a solid chunky sneaker, bright enough for a late summer rotation.','https://assets.ajio.com/medias/sys_master/root/20210627/KDfH/60d77373aeb269a9e310f5be/-473Wx593H-460848127-black-MODEL.jpg');
	insert into product (productName, price, cateID, description, image) values ('Puma Nature', 400, 4, 'The PUMA Nature covering, the sneaker into paneled leather. We love how the black leather contrast with the midsole and sweeping suede puma logo. These Puma is will not feel out of place on your trip to Italy.','https://jcpenney.scene7.com/is/image/jcpenneyimages/puma-mens-sneaker-b5901b21-2d95-42df-980d-7a0d430d9bab?scl=1&qlt=75');
    insert into product (productName, price, cateID, description, image) values ('Puma Past Rider', 500, 4, 'Love the utilitarian look of these. The disjointed gum soles paired with the grey colorway make this sneaker a minimal masterpiece','https://assets.ajio.com/medias/sys_master/root/20210627/KDfH/60d77373aeb269a9e310f5a9/-288Wx360H-460848127-black-MODEL.jpg');
	insert into product (productName, price, cateID, description, image) values ('Puma Sport Earth', 400, 4, 'RS technology but in low-maintenance black on black? Take my money. I feel batman would wear these if he had the time to be a sneakerhead.','https://assets.ajio.com/medias/sys_master/root/20210627/ItEN/60d77d51f997ddb312f39d05/-473Wx593H-460848129-blue-MODEL.jpg');
    insert into product (productName, price, cateID, description, image) values ('Puma TTD V1', 500, 4, 'The Slipstream sneaker is a shoe with a lot of history. The shoe originally appeared as a basketball sneaker in 1987 to acclaim.','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBLsul641PvA1w5pF5H6-N4Dso_CAYst0jlYCEr2z1MhVifsD0DasWGKRLxEpr_u04xvY&usqp=CAU');
    insert into product (productName, price, cateID, description, image) values ('Puma TTD V2', 600, 4, 'Speaking of Slipstream colorways, the white on red is a classic pairing that will go with just about any fit.','https://i.pinimg.com/736x/f5/4f/98/f54f9814cb1fd0a99c3ce4e81abb8d6f.jpg');
    
    insert into product (productName, price, cateID, description, image) values ('Converse All Star', 100, 3, 'The Converse All Star words "Siempre" and "Familia" stamped on the upper connect back to the family tradition.','https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/d82dc1keg33jjklyiw8l/converse-chuck-taylor-all-star-high-top-shoes-xX439O.png');
    insert into product (productName, price, cateID, description, image) values ('Converse Chuck Taylor', 200, 3, 'Prototypes have been made from leather, but they have been changed to canvas and plastic. The Converse Chuck Taylor comes in a wide variety of colors and sizes.','https://www.converse.com/dw/image/v2/BCZC_PRD/on/demandware.static/-/Sites-cnv-master-catalog/default/dw0ccb82e5/images/a_08/M7650_A_08X1.jpg?sw=406');
    insert into product (productName, price, cateID, description, image) values ('Converse Run Star', 300, 3, 'The Converse Run Star is incredibly durable and will hold up well for regular daily running sessions. ','https://www.converse.com/dw/image/v2/BCZC_PRD/on/demandware.static/-/Sites-cnv-master-catalog/default/dw29a50817/images/e_08/M9621_E_08X1.jpg?sw=406');
	insert into product (productName, price, cateID, description, image) values ('Converse Night Star', 100, 3, 'The sneaker Converse Night Star is the brainchild of two sportswear titans and includes a mesh upper in a cool blue and nubuck in a stunning olive green, all contrasting on a clean off-white midsole.','https://www.converse.com/dw/image/v2/BCZC_PRD/on/demandware.static/-/Sites-cnv-master-catalog/default/dw806c9f57/images/d_08/A02413C_D_08X1.jpg?sw=406');
    insert into product (productName, price, cateID, description, image) values ('Converse Dark Star', 100, 3, 'The Converse Dark Star inevitably building a cult following a decade later. Fans of it love the shoe is varied colorways, plush leather uppers, suede overlaps, and retro vibes.','https://www.converse.com/dw/image/v2/BCZC_PRD/on/demandware.static/-/Sites-cnv-master-catalog/default/dw8499099e/images/c_08/A02414C_C_08X1.jpg?sw=406');
    insert into product (productName, price, cateID, description, image) values ('Converse Light Star', 100, 3, 'A genuinely of Converser light Star responsive and incredibly supportive technical running shoe from Adidas and at a great price too.','https://legendary-digital-network-assets.s3.amazonaws.com/wp-content/uploads/2022/01/12190839/Poke-Ball-sneaker-from-the-new-Pokemon-shoes-Converse-collection-featuring-many-black-and-white-pokemon.jpeg');
    insert into product (productName, price, cateID, description, image) values ('Converse Shining Star', 100, 3, 'Converse Shining Star Utilizing recycled materials, these make great running shoes and are called some of the best workout shoes by gym-goers','https://spy.com/wp-content/uploads/2021/05/converse-sneakers-2021.jpg');
    insert into product (productName, price, cateID, description, image) values ('Converse Moon Star', 100, 3, 'We love the sneaker Converse Moon Star is multi-layered upper and fresh mix of leather overlays. The iridescent highlights are a nice touch too.','https://img.ssensemedia.com/images/221799F127068_1/converse-black-sunny-floral-chuck-70-high-sneakers.jpg');
    