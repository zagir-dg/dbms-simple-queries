# SQL запросы
## Ниже представлены примеры запросов к таблицам [customer](data\customer.csv) и [transaction](data\transaction.csv)

1. Вывести все уникальные бренды, у которых стандартная стоимость выше 1500 долларов.

        select distinct brand
        from transaction
        where standard_cost > 1500;

    ![№1][def]

---

2. Вывести все подтвержденные транзакции за период '2017-04-01' по '2017-04-09' включительно. 

        select * 
        from transaction
        where
            order_status = 'Approved' 
            and transaction_date between '2017-04-01' and '2017-04-09';

    ![№2][def2]

---

3. Вывести все профессии у клиентов из сферы IT или Financial Services, которые начинаются с фразы 'Senior'.
        
        select distinct job_title
        from customer
        where 
            job_industry_category in('IT', 'Financial Services')
            and job_title like 'Senior%';

    ![№3][def3]

---

4. Вывести все бренды, которые закупают клиенты, работающие в сфере Financial Services

        select distinct t.brand
        from "transaction" t 
        inner join customer c
            on t.customer_id = c.customer_id 
        where
            c.job_industry_category = 'Financial Services';

    ![№4][def4]

---

5. Вывести 10 клиентов, которые оформили онлайн-заказ продукции из брендов 'Giant Bicycles', 'Norco Bicycles', 'Trek Bicycles'.

        select c.customer_id, c.first_name, c.last_name, t.brand
        from customer c 
        inner join "transaction" t
            on t.customer_id = c.customer_id 
        where
            t.online_order = true 
            and t.brand in('Giant Bicycles', 'Norco Bicycles', 'Trek Bicycles')
        limit 10;

    ![№5][def5]

---

6. Вывести всех клиентов, у которых нет транзакций.

        select c.customer_id, c.first_name, c.last_name
        from customer c 
        left join "transaction" t
            on t.customer_id = c.customer_id
        where t.customer_id is null;

    ![№6][def6]

---

7. Вывести всех клиентов из IT, у которых транзакции с максимальной стандартной стоимостью.

        select c.customer_id, c.first_name, c.last_name, c.job_industry_category
        from customer c 
        left join "transaction" t
            on t.customer_id = c.customer_id
        where 
            c.job_industry_category = 'IT'
            and t.standard_cost = (select max(standard_cost) from "transaction");

    ![№7][def7]

---

8. Вывести всех клиентов из сферы IT и Health, у которых есть подтвержденные транзакции за период '2017-07-07' по '2017-07-17'.

        select distinct c.customer_id, c.first_name, c.last_name, c.job_industry_category, t.order_status
        from customer c
        inner join "transaction" t
            on t.customer_id = c.customer_id
        where 
            c.job_industry_category in('IT', 'Health')
            and t.order_status = 'Approved'
            and t.transaction_date between '2017-07-07' and '2017-07-17';
    
    ![№8][def8]

[def]: .\screenshots\№1.png
[def2]: .\screenshots\№2.png
[def3]: .\screenshots\№3.png
[def4]: .\screenshots\№4.png
[def5]: .\screenshots\№5.png
[def6]: .\screenshots\№6.png
[def7]: .\screenshots\№7.png
[def8]: .\screenshots\№8.png