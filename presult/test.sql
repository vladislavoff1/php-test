CREATE TABLE `order` (
  `id` int(11) NOT NULL,
  `status` enum('new','done') NOT NULL COMMENT 'new - новый, done - завершен',
  `finish_date` datetime NOT NULL COMMENT 'ставится, когда заказ оплачен и товары выданы'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Заказы';


CREATE TABLE `order_item` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `summa` decimal(10,2) NOT NULL COMMENT 'цена продажи позиции'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Позиции по заказу';
-- под каждую позицию создатеся запись, то есть если одинакового товара 2, то создается 2 записи

CREATE TABLE `payment` (
  `id` int(11) NOT NULL,
  `date` datetime NOT NULL,
  `order_id` int(11) NOT NULL,
  `summa` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Оплаты по заказам';


CREATE TABLE `product_item` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `order_item_id` int(11) DEFAULT NULL COMMENT 'позиция заказа или null',
  `status` enum('free','order') NOT NULL COMMENT ' free позиция на складе, order — в заказе (выдан)',
  `price` decimal(10,2) NOT NULL COMMENT ' сумма закупки товара'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Позиции склада';
-- если есть запись, и order_item_id = 0 и status = 'free' то позиция товара есть на складе, в противном случае позиция отдана по какому-либо заказу.

-- Задание №2

SELECT * FROM `payment` WHERE summa IS NOT NULL;

SELECT product_item.id, product_item.price, order_item.order_id, order.finish_date FROM product_item LEFT JOIN `order_item` ON product_item.product_id = order_item.product_id LEFT JOIN `order` ON order_item.order_id = order.id WHERE finish_date BETWEEN '2017.01.01' AND  '2017.01.31';

SELECT product_item.id, product_item.order_item_id FROM `product_item` LEFT JOIN `order_item` ON product_item.product_id = order_item.product_id WHERE product_item.order_item_id != 0;

