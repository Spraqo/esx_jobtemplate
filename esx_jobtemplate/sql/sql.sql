INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('hotdog',0,'hotdog','Worker', 20,'{}','{}'), -- Pretty straight forward follow the sql job_name, grade, name, label, salary, skin_male, skin_female
	('hotdog',1,'hotdog','Manager', 40,'{}','{}'),
    ('hotdog',2,'hotdog','Owner', 40,'{}','{}'),
;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('hotdog', 'Hotdog', 1); --what the job is called when /setjob and what it will say on the Hud for ex: Hotdog - Employee

INSERT INTO `addon_account` (name, label, shared) VALUES 
    ('society_hotdog','Hotdog',1) --adddon_account
;

INSERT INTO `datastore` (name, label, shared) VALUES 
    ('society_hotdog','Hotdog',1) --datastore
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES 
    ('society_hotdog', 'Hotdog', 1) --adon_inventory
;
