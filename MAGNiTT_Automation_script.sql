DELIMITER //
CREATE PROCEDURE InsertAndUpdateTables(
    IN new_id DOUBLE,
    IN startup_name VARCHAR(1024),
    IN startup_hq_id VARCHAR(1024),
    IN primary_industry_id VARCHAR(1024),
    IN number_of_founders VARCHAR(1024),
    IN revenue_generating_id DOUBLE,
    IN problem_solved VARCHAR(1024),
    IN monetization VARCHAR(1024),
    IN market_opportunity VARCHAR(1024),
    IN date_raised DATE,
    IN amount_raised DOUBLE,
    IN funding_stage_id DOUBLE,
    IN number_of_investors DOUBLE,
    IN business_type_id VARCHAR(1024)
)
BEGIN
    -- Insert into startup_formatted table
    INSERT INTO startup_formatted (startup_id, startup_name, startup_hq_id, primary_industry_id,
                                   number_of_founders, revenue_generating_id, problem_solved,
                                   monetization, market_opportunity)
    VALUES (new_id, startup_name, startup_hq_id, primary_industry_id, number_of_founders,
            revenue_generating_id, problem_solved, monetization, market_opportunity);

    -- Insert into deal_formatted table
    INSERT INTO deal_formatted (startup_id, date_raised, amount_raised, funding_stage_id, number_of_investors)
    VALUES (new_id, date_raised, amount_raised, funding_stage_id, number_of_investors);

    -- Insert into businesstype_formatted table
    INSERT INTO businesstype_formatted (startup_id, business_type_id)
    VALUES (new_id, business_type_id);
END;
//
DELIMITER ;

CREATE TABLE `Original deal_information` (
`deal_id` DOUBLE,
`startup Name` VARCHAR(1024),
`startup_id` DOUBLE,
`date_raised` DATE,
`amount_raised` DOUBLE,
`funding_stage` VARCHAR(1024),
`funding_stage_id` DOUBLE,
`number_of_investors` DOUBLE,
`startup_hq` VARCHAR(1024),
`startup_hq_trim` VARCHAR(1024),
`startup_hq_fixed` VARCHAR(1024),
`startup_hq_id` VARCHAR(1024),
`primary_industry` VARCHAR(1024),
`primary_industry_fixed` VARCHAR(1024),
`primary_industry_id` VARCHAR(1024),
`number_of_founders` VARCHAR(1024),
`business_type` VARCHAR(1024),
`business_type_id` VARCHAR(1024),
`revenue_generating` VARCHAR(1024),
`revenue_generating_id` DOUBLE,
`problem_solved` VARCHAR(1024),
`monetization` VARCHAR(1024),
`market_opportunity` VARCHAR(1024)
);

CREATE TABLE `startup_formatted` (
`startup_id` DOUBLE,
`startup_name` VARCHAR(1024),
`startup_hq_id` VARCHAR(1024),
`primary_industry_id` VARCHAR(1024),
`number_of_founders` VARCHAR(1024),
`revenue_generating_id` DOUBLE,
`problem_solved` VARCHAR(1024),
`monetization` VARCHAR(1024),
`market_opportunity` VARCHAR(1024)
);
-- Insert into deal_formatted table
CREATE TABLE ` deal_formatted` (
`startup_id` DOUBLE,
`date_raised` DATE,
`amount_raised` DOUBLE,
`funding_stage_id` DOUBLE,
`number_of_investors` DOUBLE
);

CREATE TABLE `businesstype_formatted` (
`startup_id` DOUBLE,
`business_type_id` VARCHAR(1024)
);
-- Insert into startup_formatted table
DELIMITER //
CREATE TRIGGER tr_original_insert_startup
AFTER INSERT ON `Original deal_information`
FOR EACH ROW
BEGIN
    INSERT INTO `startup_formatted` (
        `startup_id`,
        `startup_name`,
        `startup_hq_id`,
        `primary_industry_id`,
        `number_of_founders`,
        `revenue_generating_id`,
        `problem_solved`,
        `monetization`,
        `market_opportunity`
    )
    VALUES (
        NEW.startup_id,
        NEW.startup_Name,
        NEW.startup_hq_id,
        NEW.primary_industry_id,
        NEW.number_of_founders,
        NEW.revenue_generating_id,
        NEW.problem_solved,
        NEW.monetization,
        NEW.market_opportunity
    );
END;
//
DELIMITER ;
-- Insert into deal_formatted table
DELIMITER //
CREATE TRIGGER tr_original_insert_deal
AFTER INSERT ON `Original deal_information`
FOR EACH ROW
BEGIN
    INSERT INTO `deal_formatted` (
        `startup_id`,
        `date_raised`,
        `amount_raised`,
        `funding_stage_id`,
        `number_of_investors`
    )
    VALUES (
        NEW.startup_id,
        NEW.date_raised,
        NEW.amount_raised,
        NEW.funding_stage_id,
        NEW.number_of_investors
    );
END;
//
DELIMITER ;
-- Insert into businesstype_formatted table
DELIMITER //
CREATE TRIGGER tr_original_insert_businesstype
AFTER INSERT ON `Original deal_information`
FOR EACH ROW
BEGIN
    INSERT INTO `businesstype_formatted` (
        `startup_id`,
        `business_type_id`
    )
    VALUES (
        NEW.startup_id,
        NEW.business_type_id
    );
END;
//
DELIMITER ;

