show con_name
alter session set container=orclpdb

grant select on sales.orders , sales.staffs,sales.stores,sales.customers,sales.order_items to production

GRANT SELECT ON production.brands TO sales;
GRANT SELECT ON production.categories TO sales;
GRANT SELECT ON production.products TO sales;
GRANT SELECT ON production.stocks TO sales;
