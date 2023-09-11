-- Down Script


IF OBJECT_ID('dbo.event_models', 'U') IS NOT NULL
    DROP TABLE dbo.event_models;
IF OBJECT_ID('dbo.event_runways', 'U') IS NOT NULL
    DROP TABLE dbo.event_runways;
IF OBJECT_ID('dbo.event_designers', 'U') IS NOT NULL
    DROP TABLE dbo.event_designers;
IF OBJECT_ID('dbo.collections', 'U') IS NOT NULL
BEGIN
    ALTER TABLE dbo.collections
    DROP CONSTRAINT FK_collection_designer;
    DROP TABLE dbo.collections;
END
IF OBJECT_ID('dbo.runways', 'U') IS NOT NULL
    DROP TABLE dbo.runways;
IF OBJECT_ID('dbo.models', 'U') IS NOT NULL
    DROP TABLE dbo.models;
IF OBJECT_ID('dbo.designers', 'U') IS NOT NULL
    DROP TABLE dbo.designers;
IF OBJECT_ID('dbo.events', 'U') IS NOT NULL
    DROP TABLE dbo.events;

-- UP script

use SQLfinalproject

CREATE TABLE [dbo].[events](
    [event_id] [nvarchar](10) NOT NULL,
    [event_name] [nvarchar](100) NOT NULL,
    [event_country] [nvarchar](20) NOT NULL,
    [event_location] [nvarchar] (50) NULL,
    [event_type] [nvarchar](20) NULL,
    [event_date] [date] NOT NULL,
    [event_time] [time](7) NOT NULL,
    CONSTRAINT [PK_events] PRIMARY KEY CLUSTERED ([event_id] ASC)
)

CREATE TABLE [dbo].[designers](
    [designer_id] [nvarchar](10) NOT NULL,
    [designer_firstname] [nvarchar](15) NOT NULL,
    [designer_lastname] [nvarchar](15) NOT NULL,
    [designer_label] [nvarchar](20) NOT NULL,
    [designer_country] [nvarchar](15) NOT NULL,
    [designer_number] [int] NULL,
    [designer_email] [nvarchar](50) NULL,
    CONSTRAINT [PK_designers] PRIMARY KEY CLUSTERED ([designer_id] ASC)
)

CREATE TABLE [dbo].[models](
    [model_id] [nvarchar](10) NOT NULL,
    [model_firstname] [nvarchar](15) NOT NULL,
    [model_lastname] [nvarchar](15) NOT NULL,
    [model_age] [nvarchar](5) NOT NULL,
    [model_height] [int] NULL,
    [model_weight] [int] NULL,
    [model_country] [nvarchar](20) NULL,
    CONSTRAINT [PK_models] PRIMARY KEY CLUSTERED ([model_id] ASC)
)

CREATE TABLE [dbo].[runways](
    [runway_id] [nvarchar](10) NOT NULL,
    [runway_time] [time](7) NOT NULL,
    [runway_type] [nvarchar](15) NOT NULL,
    CONSTRAINT [PK_runways] PRIMARY KEY CLUSTERED ([runway_id] ASC)
)

CREATE TABLE [dbo].[collections](
    [collection_id] [nvarchar](10) NOT NULL,
    [collection_name] [nvarchar](20) NOT NULL,
    [collection_year] int NOT NULL,
    [collection_description] [nvarchar](max) NULL,
    [designer_ID] [nvarchar](10) NOT NULL,
    CONSTRAINT [PK_collections] PRIMARY KEY CLUSTERED ([collection_id] ASC),
    CONSTRAINT [FK_collection_designer] FOREIGN KEY ([designer_ID]) REFERENCES [dbo].[designers] ([designer_id])
)

CREATE TABLE [dbo].[event_models](
    [em_id] [nvarchar](5) NOT NULL,
    [event_id] [nvarchar](10) NOT NULL,
    [model_id] [nvarchar](10) NOT NULL,
    CONSTRAINT [PK_event_models] PRIMARY KEY CLUSTERED ([em_id] ASC),
    CONSTRAINT [FK_event_models_event_id] FOREIGN KEY ([event_id]) REFERENCES [dbo].[events]([event_id]),
    CONSTRAINT [FK_event_models_model_id] FOREIGN KEY ([model_id]) REFERENCES [dbo].[models]([model_id])
)

CREATE TABLE [dbo].[event_runways](
    [er_id] [nvarchar] (5) NOT NULL,
    [event_id] [nvarchar](10) NOT NULL,
    [runway_id] [nvarchar](10) NOT NULL,
    CONSTRAINT [PK_event_runways] PRIMARY KEY CLUSTERED ([er_id] ASC),
    CONSTRAINT [FK_event_runways_event_id] FOREIGN KEY ([event_id]) REFERENCES [dbo].[events]([event_id]),
    CONSTRAINT [FK_event_runways_runway_id] FOREIGN KEY ([runway_id]) REFERENCES [dbo].[runways]([runway_id])
)

CREATE TABLE [dbo].[event_designers](
    [ed_id] [nvarchar](5) NOT NULL,
    [event_id] [nvarchar](10) NOT NULL,
    [designer_id] [nvarchar](10) NOT NULL,
    CONSTRAINT [PK_event_designers] PRIMARY KEY CLUSTERED ([ed_id] ASC),
    CONSTRAINT [FK_event_designers_event_id] FOREIGN KEY ([event_id]) REFERENCES [dbo].[events]([event_id]),
    CONSTRAINT [FK_event_designers_designer_id] FOREIGN KEY ([designer_id]) REFERENCES [dbo].[designers]([designer_id])
)

-- insert data  into events table

INSERT INTO [dbo].[events] ([event_id], [event_name], [event_country], [event_location], [event_type], [event_date], [event_time])
VALUES 
    ('E103', 'Chanel', 'France', 'Paris', 'Runway', '2023-11-01', '20:00:00'),
    ('E104', 'Louis Vuitton', 'France', 'Paris', 'Presentation', '2023-12-01', '21:00:00'),
    ('E105', 'Ralph Lauren', 'USA', 'New York City', 'Runway', '2023-10-01', '18:00:00'),
    ('E106', 'Versace', 'Italy', 'Milan', 'Runway', '2023-10-02', '18:00:00'),
    ('E107', 'Calvin Klein', 'USA', 'New York City', 'Presentation', '2023-10-03', '19:00:00'),
    ('E108', 'Gucci', 'Italy', 'Florence', 'Runway', '2023-10-04', '20:00:00'),
    ('E109', 'Balenciaga', 'France', 'Paris', 'Runway', '2023-10-05', '21:00:00'),
    ('E110', 'Dior', 'France', 'Paris', 'Presentation', '2023-10-06', '18:00:00'),
    ('E111', 'Fendi', 'Italy', 'Milan', 'Online', '2023-10-07', '19:00:00'),
    ('E112', 'Prada', 'Italy', 'Milan', 'Runway', '2023-10-08', '20:00:00'),
    ('E113', 'Hermes', 'France', 'Paris', 'Presentation', '2023-10-09', '21:00:00'),
    ('E114', 'Chloe', 'France', 'Paris', 'Runway', '2023-11-02', '18:00:00'),
    ('E115', 'Bottega Veneta', 'Italy', 'Milan', 'Runway', '2023-11-03', '19:00:00'),
    ('E116', 'Yves Saint Laurent', 'France', 'Paris', 'Presentation', '2023-11-04', '20:00:00'),
    ('E117', 'Michael Kors', 'USA', 'New York City', 'Runway', '2023-11-05', '21:00:00'),
    ('E118', 'Burberry', 'UK', 'London', 'Presentation', '2023-11-06', '18:00:00'),
    ('E119', 'Alexander McQueen', 'UK', 'London', 'Runway', '2023-11-07', '19:00:00'),
    ('E120', 'Tommy Hilfiger', 'USA', 'New York City', 'Online', '2023-11-08', '20:00:00'),
    ('E121', 'Isabel Marant', 'France', 'Paris', 'Runway', '2023-11-09', '21:00:00'),
    ('E122', 'Dolce & Gabbana', 'Italy', 'Milan', 'Presentation', '2023-12-02', '18:00:00'),
    ('E123', 'Balenciaga', 'France', 'Paris', 'Runway', '2023-11-03', '15:00:00'),
    ('E124', 'Chanel', 'France', 'Paris', 'Runway', '2023-11-05', '19:00:00'),
    ('E125', 'Louis Vuitton', 'France', 'Paris', 'Presentation', '2023-11-07', '10:00:00'),
    ('E126', 'Gucci', 'Italy', 'Milan', 'Runway', '2023-11-08', '18:00:00'),
    ('E127', 'Versace', 'Italy', 'Milan', 'Runway', '2023-11-09', '17:00:00'),
    ('E128', 'Prada', 'Italy', 'Milan', 'Presentation', '2023-11-10', '12:00:00'),
    ('E129', 'Valentino', 'Italy', 'Rome', 'Runway', '2023-11-12', '20:00:00'),
    ('E130', 'Dior', 'France', 'Paris', 'Runway', '2023-11-15', '19:00:00'),
    ('E131', 'Burberry', 'UK', 'London', 'Runway', '2023-11-17', '16:00:00'),
    ('E132', 'Alexander McQueen', 'UK', 'London', 'Presentation', '2023-11-18', '11:00:00'),
    ('E133', 'Ralph Lauren', 'USA', 'New York City', 'Runway', '2023-11-20', '19:00:00'),
    ('E134', 'Calvin Klein', 'USA', 'New York City', 'Runway', '2023-11-22', '20:00:00'),
    ('E135', 'Tommy Hilfiger', 'USA', 'New York City', 'Presentation', '2023-11-24', '12:00:00'),
    ('E136', 'Fendi', 'Italy', 'Milan', 'Runway', '2023-11-27', '17:00:00'),
    ('E137', 'Hermès', 'France', 'Paris', 'Presentation', '2023-11-29', '10:00:00'),
    ('E138', 'Balmain', 'France', 'Paris', 'Runway', '2023-12-02', '19:00:00'),
    ('E139', 'Isabel Marant', 'France', 'Paris', 'Presentation', '2023-12-03', '11:00:00'),
    ('E140', 'Miu Miu', 'Italy', 'Venice', 'Runway', '2023-12-05', '15:00:00'),
    ('E141', 'Bottega Veneta', 'Italy', 'Venice', 'Runway', '2023-12-06', '14:00:00'),
    ('E142', 'Ganni', 'Denmark', 'Copenhagen', 'Presentation', '2023-12-08', '13:00:00'),
    ('E143', 'Michael Kors', 'USA', 'Los Angeles', 'Runway', '2023-11-14', '14:30:00'),
    ('E144', 'Ralph Lauren', 'USA', 'New York City', 'Presentation', '2023-11-20', '11:00:00'),
    ('E145', 'Victoria Beckham', 'UK', 'London', 'Runway', '2023-12-03', '19:30:00'),
    ('E146', 'Gucci', 'Italy', 'Milan', 'Online', '2023-12-10', '16:00:00'),
    ('E147', 'Chanel', 'France', 'Paris', 'Presentation', '2023-12-17', '15:00:00'),
    ('E148', 'Balenciaga', 'France', 'Paris', 'Runway', '2024-01-15', '19:00:00'),
    ('E149', 'Dolce & Gabbana', 'Italy', 'Milan', 'Online', '2024-02-05', '18:00:00'),
    ('E150', 'Valentino', 'Italy', 'Rome', 'Runway', '2024-02-14', '20:00:00')

INSERT INTO [dbo].[events] ([event_id], [event_name], [event_country], [event_location], [event_type], [event_date], [event_time])
VALUES 
    ('E101', 'Tom Ford', 'USA', 'New York City', 'Fashion Show', '2023-09-01', '18:00:00'),
    ('E102',  'Givenchy', 'France', 'Paris', 'Fashion Show', '2023-10-01', '19:00:00')

select * from events


-- insert data  into designers table


ALTER TABLE designers
ALTER COLUMN [designer_number] VARCHAR(10);

INSERT INTO [dbo].[designers] ([designer_id], [designer_firstname], [designer_lastname], [designer_label], [designer_country], [designer_number], [designer_email])
VALUES 
    ('D101', 'Tom', 'Ford', 'Tom Ford', 'USA', 1234567890, 'tf@tomford.com'),
    ('D102', 'Riccardo', 'Tisci', 'Givenchy', 'Italy', 2345678901, 'rt@givenchy.com'),
    ('D103', 'Virgil', 'Abloh', 'Off-White', 'USA', 3456789012, 'va@off---white.com'),
    ('D104', 'Miuccia', 'Prada', 'Prada', 'Italy', 4567890123, 'mp@prada.com'),
    ('D105', 'Marc', 'Jacobs', 'Marc Jacobs', 'USA', 5678901234, 'mj@marcjacobs.com'),
    ('D106', 'Karl', 'Lagerfeld', 'Karl Lagerfeld', 'Germany', 6789012345, 'kl@karllagerfeld.com'),
    ('D107', 'Stella', 'McCartney', 'Stella McCartney', 'UK', 7890123456, 'sm@stellamccartney.com'),
    ('D108', 'Donatella', 'Versace', 'Versace', 'Italy', 8901234567, 'dv@versace.com'),
    ('D109', 'Ralph', 'Lauren', 'Ralph Lauren', 'USA', 9012345678, 'rl@ralphlauren.com'),
    ('D110', 'Calvin', 'Klein', 'Calvin Klein', 'USA', 1234567890, 'ck@calvinklein.com'),
    ('D111', 'Gucci', 'Guccio', 'Gucci', 'Italy', 2345678901, 'gg@gucci.com'),
    ('D112', 'Alexander', 'McQueen', 'Alexander McQueen', 'UK', 3456789012, 'am@alexandermcqueen.com'),
    ('D113', 'Christian', 'Dior', 'Christian Dior', 'France', 4567890123, 'cd@dior.com'),
    ('D114', 'Yves', 'Saint Laurent', 'YSL', 'France', 5678901234, 'ysl@ysl.com'),
    ('D115', 'Jean-Paul', 'Gaultier', 'Jean-Paul Gaultier', 'France', 6789012345, 'jpg@jpg.com'),
    ('D116', 'Olivier', 'Rousteing', 'Balmain', 'France', 7890123456, 'or@balmain.com'),
    ('D117', 'Jeremy', 'Scott', 'Moschino', 'USA', 8901234567, 'js@moschino.com'),
    ('D118', 'Tommy', 'Hilfiger', 'Tommy Hilfiger', 'USA', 9012345678, 'th@tommyhilfiger.com'),
    ('D119', 'Kris', 'Van Assche', 'Dior Homme', 'Belgium', 1234567890, 'kva@diorhomme.com'),
    ('D120', 'Phoebe', 'Philo', 'Celine', 'UK', 6789012345, 'pp@celine.com'),
    ('D121', 'Pierpaolo', 'Piccioli', 'Valentino', 'Italy', 8901234567, 'pp@valentino.com'),
    ('D122', 'Hedi', 'Slimane', 'Celine', 'France', 4567890123, 'hs@celine.com'),
    ('D123', 'Raf', 'Simons', 'Raf Simons', 'Belgium', 7890123456, 'rs@rafsimons.com'),
    ('D124', 'Dries', 'Van Noten', 'Dries Van Noten', 'Belgium', 8901234567, 'dvn@driesvannoten.com'),
    ('D125', 'Pharrell', 'Williams', 'Chanel x Pharrell', 'USA', 9012345678, 'pw@chanel.com'),
    ('D126', 'Victoria', 'Beckham', 'Victoria Beckham', 'UK', 2345678901, 'vb@victoriabeckham.com'),
    ('D127', 'Thom', 'Browne', 'Thom Browne', 'USA', 3456789012, 'tb@thombrowne.com'),
    ('D128', 'Christopher', 'Kane', 'Christopher Kane', 'UK', 4567890123, 'ck@christopherkane.com'),
    ('D129', 'Mary-Kate', 'Olsen', 'The Row', 'USA', 5678901234, 'mk@therow.com'),
    ('D130', 'Ashley', 'Olsen', 'The Row', 'USA', 6789012345, 'ao@therow.com'),
    ('D131', 'Erdem', 'Moralioglu', 'Erdem', 'UK', 7890123456, 'em@erdem.com'),
    ('D132', 'Humberto', 'Leon', 'Kenzo', 'USA', 8901234567, 'hl@kenzo.com'),
    ('D133', 'Carol', 'Lim', 'Kenzo', 'USA', 1234567890, 'cl@kenzo.com'),
    ('D134', 'Alessandro', 'Michele', 'Gucci', 'Italy', 2345678901, 'am@gucci.com')


select * from designers


-- insert data  into models table

INSERT INTO [dbo].[models] ([model_id], [model_firstname], [model_lastname], [model_age], [model_height], [model_weight], [model_country])
VALUES
    ('M101', 'Gigi', 'Hadid', '26', 178, 57, 'USA'),
    ('M102', 'Bella', 'Hadid', '24', 175, 55, 'USA'),
    ('M103', 'Kaia', 'Gerber', '20', 173, 52, 'USA'),
    ('M104', 'Adut', 'Akech', '21', 180, 53, 'South Sudan'),
    ('M105', 'Joan', 'Smalls', '33', 180, 52, 'Puerto Rico'),
    ('M106', 'Candice', 'Swanepoel', '33', 177, 55, 'South Africa'),
    ('M107', 'Liu', 'Wen', '33', 178, 54, 'China'),
    ('M108', 'Karlie', 'Kloss', '29', 188, 58, 'USA'),
    ('M109', 'Taylor', 'Hill', '25', 176, 55, 'USA'),
    ('M110', 'Adwoa', 'Aboah', '29', 177, 56, 'UK'),
    ('M111', 'Precious', 'Lee', '23', 175, 120, 'USA'),
    ('M112', 'Paloma', 'Elsesser', '29', 173, 85, 'USA'),
    ('M113', 'Mayowa', 'Nicholas', '23', 180, 56, 'Nigeria'),
    ('M114', 'Rianne', 'Van Rompaey', '25', 180, 54, 'Belgium'),
    ('M115', 'Grace', 'Elizabeth', '24', 178, 52, 'USA')

INSERT INTO [dbo].[models] ([model_id], [model_firstname], [model_lastname], [model_age], [model_height], [model_weight], [model_country])
VALUES
    ('M116', 'Lara', 'Stone', '38', 177, 58, 'Netherlands'),
    ('M117', 'Karlie', 'Kloss', '29', 185, 56, 'USA'),
    ('M118', 'Alek', 'Wek', '44', 180, 50, 'South Sudan'),
    ('M119', 'Fei', 'Fei Sun', '32', 178, 52, 'China'),
    ('M120', 'Adriana', 'Lima', '40', 178, 55, 'Brazil'),
    ('M121', 'Bella', 'Hadid', '25', 175, 55, 'USA'),
    ('M122', 'Liu', 'Wen', '33', 178, 50, 'China'),
    ('M123', 'Naomi', 'Campbell', '51', 175, 56, 'UK'),
    ('M124', 'Gisele', 'Bündchen', '41', 180, 59, 'Brazil'),
    ('M125', 'Ming', 'Xi', '32', 178, 52, 'China'),
    ('M126', 'Cara', 'Delevingne', '29', 173, 51, 'UK'),
    ('M127', 'Irina', 'Shayk', '35', 178, 53, 'Russia'),
    ('M128', 'Doutzen', 'Kroes', '36', 180, 54, 'Netherlands'),
    ('M129', 'Rosie', 'Huntington', '34', 175, 52, 'UK'),
    ('M130', 'Tyra', 'Banks', '48', 178, 65, 'USA')


select * from models


-- insert data  into runways table


INSERT INTO [dbo].[runways] ([runway_id], [runway_time], [runway_type]) 
VALUES 
('RW101', '09:00:00', 'formal'),
('RW102', '12:30:00', 'informal'),
('RW103', '15:00:00', 'formal'),
('RW104', '11:00:00', 'informal'),
('RW105', '14:30:00', 'formal'),
('RW106', '10:30:00', 'informal'),
('RW107', '16:00:00', 'formal'),
('RW108', '13:00:00', 'informal'),
('RW109', '17:30:00', 'formal'),
('RW110', '18:00:00', 'informal'),
('RW111', '19:00:00', 'formal'),
('RW112', '20:00:00', 'informal'),
('RW113', '21:00:00', 'formal'),
('RW114', '22:00:00', 'informal'),
('RW115', '23:00:00', 'formal')

select * from runways


-- insert data  into collections table

INSERT INTO [dbo].[collections] ([collection_id], [collection_name], [collection_year], [collection_description], [designer_ID])
VALUES
    ('c101', 'Spring/Summer', 2022, 'Bold colors and patterns inspired by nature', 'D101'),
    ('c102', 'Fall/Winter', 2022, 'Minimalist designs with a focus on texture and shape', 'D102'),
    ('c103', 'Resort', 2022, 'Relaxed, beachy vibes with breezy fabrics and bright colors', 'D103'),
    ('c104', 'Pre-Fall', 2022, 'Neutral tones and tailored pieces for a transitional wardrobe', 'D104'),
    ('c105', 'Spring', 2022, 'Florals and pastels in feminine silhouettes', 'D105'),
    ('c106', 'Cruise', 2022, 'Nautical-inspired designs with stripes and anchor motifs', 'D106'),
    ('c107', 'Summer', 2022, 'Lightweight fabrics and playful prints for warmer weather', 'D107'),
    ('c108', 'Fall', 2023, 'Rich hues and textured fabrics in cozy styles', 'D108'),
    ('c109', 'Spring/Summer', 2023, 'Bohemian-inspired designs with fringe and embroidery', 'D109'),
    ('c110', 'Resort', 2023, 'Luxurious fabrics and tropical prints for a vacation-ready wardrobe', 'D110'),
    ('c111', 'Pre-Fall', 2023, 'Sophisticated separates in classic neutrals', 'D111'),
    ('c112', 'Summer', 2023, 'Glamorous eveningwear with sparkling embellishments', 'D112'),
    ('c113', 'Cruise', 2023, 'Effortless pieces in bold colors and playful prints', 'D113'),
    ('c114', 'Summer', 2024, 'Light and airy fabrics in flowing silhouettes', 'D114'),
    ('c115', 'Fall/Winter', 2024, 'Sleek and modern designs in muted colors', 'D115'),
    ('c116', 'Spring/Summer', 2024, 'Retro-inspired designs with bold patterns and statement accessories', 'D116'),
    ('c117', 'Resort', 2024, 'Effortlessly chic styles in soft colors and textures', 'D117'),
    ('c118', 'Pre-Fall', 2024, 'Structured and tailored pieces in menswear-inspired styles', 'D118'),
    ('c119', 'Cruise', 2024, 'Fresh and modern designs in geometric prints and bright colors', 'D119'),
    ('c120', 'Cruise', 2025, 'Playful prints and bold accessories for a vacation-ready wardrobe', 'D120'),
    ('c121', 'Summer', 2025, 'Casual and comfortable pieces in breathable fabrics and bright colors', 'D121'),
    ('c122', 'Resort', 2025, 'Modern takes on classic silhouettes', 'D122'),
    ('c123', 'Fall/Winter', 2025, 'Luxurious fabrics with bold embellishments', 'D123'),
    ('c124', 'Spring', 2025, 'Nautical-inspired designs with stripes and anchors', 'D123'),
    ('c125', 'Spring/Summer', 2025, 'Bohemian vibes with lots of fringe and lace', 'D124'),
    ('c126', 'Pre-Fall', 2026, 'Sleek and sophisticated designs with pops of color', 'D125'),
    ('c127', 'Resort', 2026, 'Relaxed beachy looks with earthy tones', 'D126'),
    ('c128', 'Spring/Summer', 2026, 'Flirty dresses with feminine floral prints', 'D127'),
    ('c129', 'Summer', 2026, 'Sporty-chic looks with neon accents', 'D128'),
    ('c130', 'Fall', 2026, 'Elegant gowns with intricate beading and lace', 'D129')

select * from collections


-- insert data  into event_models table

INSERT INTO [dbo].[event_models] ([em_id], [event_id], [model_id])
VALUES
    ('em001', 'E101', 'M124'),
    ('em002', 'E101', 'M120'),
    ('em003', 'E101', 'M112'),
    ('em004', 'E101', 'M102'),
    ('em005', 'E102', 'M122'),
    ('em006', 'E102', 'M124'),
    ('em007', 'E102', 'M128'),
    ('em008', 'E103', 'M101'),
    ('em009', 'E103', 'M103'),
    ('em010', 'E103', 'M120'),
    ('em011', 'E103', 'M113'),
    ('em012', 'E103', 'M111'),
    ('em013', 'E104', 'M109'),
    ('em014', 'E104', 'M111'),
    ('em015', 'E104', 'M117'),
    ('em016', 'E104', 'M102'),
    ('em017', 'E104', 'M103'),
    ('em018', 'E105', 'M102'),
    ('em019', 'E105', 'M127'),
    ('em020', 'E105', 'M126'),
    ('em021', 'E105', 'M120'),
    ('em022', 'E150', 'M105'),
    ('em023', 'E150', 'M107'),
    ('em024', 'E150', 'M116'),
    ('em025', 'E150', 'M121'),
    ('em026', 'E136', 'M125'),
    ('em027', 'E136', 'M130'),
    ('em028', 'E136', 'M113'),
    ('em029', 'E136', 'M123'),
    ('em030', 'E136', 'M125'),
    ('em031', 'E125', 'M125'),
    ('em032', 'E125', 'M123'),
    ('em033', 'E125', 'M121'),
    ('em034', 'E125', 'M106'),
    ('em035', 'E125', 'M102'),
    ('em036', 'E125', 'M108'),
    ('em037', 'E116', 'M122'),
    ('em038', 'E116', 'M127'),
    ('em039', 'E116', 'M130'),
    ('em040', 'E116', 'M123'),
    ('em041', 'E116', 'M125'),
    ('em042', 'E147', 'M124'),
    ('em043', 'E142', 'M102'),
    ('em044', 'E147', 'M104'),
    ('em045', 'E143', 'M101'),
    ('em046', 'E147', 'M130'),
    ('em047', 'E146', 'M125'),
    ('em048', 'E133', 'M104'),
    ('em049', 'E133', 'M130'),
    ('em050', 'E133', 'M128'),
    ('em051', 'E132', 'M126'),
    ('em052', 'E133', 'M125'),
    ('em053', 'E139', 'M123'),
    ('em054', 'E139', 'M127'),
    ('em055', 'E127', 'M125'),
    ('em056', 'E127', 'M101'),
    ('em057', 'E127', 'M113'),
    ('em058', 'E133', 'M127'),
    ('em059', 'E133', 'M128'),
    ('em060', 'E133', 'M119'),
    ('em061', 'E109', 'M109'),
    ('em062', 'E109', 'M106')

    select * from event_models


-- insert data  into event_runways table


INSERT INTO [dbo].[event_runways] ([er_id], [event_id], [runway_id])
VALUES 
    ('er001', 'E101', 'Rw101'),
    ('er002', 'E123', 'RW101'),
    ('er003', 'E134', 'RW101'),
    ('er004', 'E135', 'RW101'),
    ('er005', 'E103', 'RW102'),
    ('er006', 'E121', 'RW102'),
    ('er007', 'E125', 'RW102'),
    ('er008', 'E116', 'RW103'),
    ('er009', 'E119', 'RW103'),
    ('er010', 'E128', 'RW103'),
    ('er011', 'E145', 'RW104'),
    ('er012', 'E136', 'RW104'),
    ('er013', 'E138', 'RW104'),
    ('er014', 'E104', 'RW104'),
    ('er015', 'E103', 'RW105'),
    ('er016', 'E148', 'RW105'),
    ('er017', 'E147', 'RW105'),
    ('er018', 'E136', 'RW106'),
    ('er019', 'E122', 'RW106'),
    ('er020', 'E111', 'RW106'),
    ('er021', 'E133', 'RW106'),
    ('er022', 'E144', 'RW106'),
    ('er023', 'E142', 'RW107'),
    ('er024', 'E138', 'RW107'),
    ('er025', 'E126', 'RW107'),
    ('er026', 'E107', 'RW107'),
    ('er027', 'E135', 'RW108'),
    ('er028', 'E124', 'RW108'),
    ('er029', 'E104', 'RW108'),
    ('er030', 'E102', 'RW108'),
    ('er031', 'E106', 'RW109'),
    ('er032', 'E108', 'RW109'),
    ('er033', 'E144', 'RW109'),
    ('er034', 'E132', 'RW110'),
    ('er035', 'E145', 'RW110'),
    ('er036', 'E130', 'RW110'),
    ('er037', 'E110', 'RW111'),
    ('er038', 'E120', 'RW111'),
    ('er039', 'E130', 'RW111'),
    ('er040', 'E103', 'RW112')

SELECT * FROM  event_runways

-- insert data  into event_designers table

INSERT INTO [dbo].[event_designers] ([ed_id], [event_id], [designer_id])
VALUES 
    ('ed101', 'E101', 'D101'),
    ('ed102', 'E101', 'D102'),
    ('ed103', 'E101', 'D103'),
    ('ed104', 'E102', 'D101'),
    ('ed105', 'E102', 'D104'),
    ('ed106', 'E103', 'D105'),
    ('ed107', 'E104', 'D106'),
    ('ed108', 'E104', 'D107'),
    ('ed109', 'E104', 'D108'),
    ('ed110', 'E105', 'D109'),
    ('ed111', 'E106', 'D110'),
    ('ed112', 'E106', 'D111'),
    ('ed113', 'E107', 'D109'),
    ('ed114', 'E107', 'D112'),
    ('ed115', 'E108', 'D113'),
    ('ed116', 'E109', 'D134'),
    ('ed117', 'E109', 'D110'),
    ('ed118', 'E110', 'D104'),
    ('ed119', 'E110', 'D133'),
    ('ed120', 'E110', 'D131'),
    ('ed121', 'E111', 'D115'),
    ('ed122', 'E111', 'D116'),
    ('ed123', 'E112', 'D130'),
    ('ed124', 'E112', 'D120'),
    ('ed125', 'E113', 'D102'),
    ('ed126', 'E114', 'D101'),
    ('ed127', 'E114', 'D103'),
    ('ed128', 'E115', 'D118'),
    ('ed129', 'E116', 'D119'),
    ('ed130', 'E116', 'D120'),
    ('ed131', 'E117', 'D111'),
    ('ed132', 'E117', 'D123'),
    ('ed133', 'E118', 'D125'),
    ('ed134', 'E118', 'D134'),
    ('ed135', 'E119', 'D121'),
    ('ed136', 'E119', 'D134'),
    ('ed137', 'E120', 'D112'),
    ('ed138', 'E120', 'D107'),
    ('ed139', 'E121', 'D122'),
    ('ed140', 'E121', 'D129'),
    ('ed141', 'E122', 'D134'),
    ('ed142', 'E122', 'D123'),
    ('ed143', 'E123', 'D133'),
    ('ed144', 'E123', 'D129'),
    ('ed145', 'E124', 'D133'),
    ('ed146', 'E125', 'D112'),
    ('ed147', 'E125', 'D104'),
    ('ed148', 'E126', 'D133'),
    ('ed149', 'E126', 'D118'),
    ('ed150', 'E127', 'D110'),
    ('ed151', 'E127', 'D131'),
    ('ed152', 'E128', 'D126'),
    ('ed153', 'E128', 'D123'),
    ('ed154', 'E129', 'D118'),
    ('ed155', 'E129', 'D109'),
    ('ed156', 'E130', 'D111'),
    ('ed157', 'E130', 'D126'),
    ('ed158', 'E131', 'D129'),
    ('ed159', 'E131', 'D131'),
    ('ed160', 'E133', 'D103')

select * from event_designers

-- report 1 : count the number of models in different age groups to determine the age group that has max number of models
SELECT 
    CASE 
        WHEN model_age >= 21 AND model_age < 27 THEN '21-26'
        WHEN model_age >= 27 AND model_age < 33 THEN '27-32'
        WHEN model_age >= 33 AND model_age < 39 THEN '33-38'
        WHEN model_age >= 39 AND model_age < 45 THEN '39-44'
        WHEN model_age >= 45 AND model_age < 51 THEN '45-50'
        ELSE 'Unknown'
    END AS age_group,
    COUNT(*) AS num_of_models
FROM models
GROUP BY 
    CASE 
        WHEN model_age >= 21 AND model_age < 27 THEN '21-26'
        WHEN model_age >= 27 AND model_age < 33 THEN '27-32'
        WHEN model_age >= 33 AND model_age < 39 THEN '33-38'
        WHEN model_age >= 39 AND model_age < 45 THEN '39-44'
        WHEN model_age >= 45 AND model_age < 51 THEN '45-50'
        ELSE 'Unknown'
    END
ORDER BY age_group;

-- report 2 : counting the number of models performing in every event
SELECT e.event_id, e.event_name, COUNT(em.model_id) AS num_models
FROM events e
LEFT JOIN event_models em ON e.event_id = em.event_id
GROUP BY e.event_id, e.event_name;


-- report 3 : designers names with the events that they are participating in with their event ids

SELECT DISTINCT CONCAT(d.designer_firstname, ' ', d.designer_lastname) AS designer_name, e.event_name, ed.event_id
FROM designers d
JOIN event_designers ed
ON d.designer_id = ed.designer_id
JOIN events e
ON e.event_id = ed.event_id;

-- report 4 : procedure to update an entry in the designers table
CREATE PROCEDURE UpdateDesigner
    @id NVARCHAR(10),
    @first_name NVARCHAR(50),
    @last_name NVARCHAR(50),
    @label NVARCHAR(50),
    @country NVARCHAR(50),
    @number NVARCHAR(20),
    @email NVARCHAR(50)
AS
BEGIN
    UPDATE designers
    SET 
        designer_firstname = @first_name,
        designer_lastname = @last_name,
        designer_label = @label,
        designer_country = @country,
        designer_number = @number,
        designer_email = @email
    WHERE
        designer_id = @id
END

select * from designers where designer_id = 'D130'

EXEC UpdateDesigner 'D130', 'John', 'Doe', 'JD Fashion', 'USA', 5555555555, 'johndoe@email.com'


select * from designers where designer_firstname='John'

-- report 5 : trigger on the designers table to remove all references to the designer in the event_designers table when a designer is deleted 

CREATE TRIGGER trg_DeleteDesigner
ON designers
FOR DELETE
AS
BEGIN
    DELETE FROM event_designers
    WHERE designer_id IN (SELECT designer_id FROM deleted);
END

select * from event_designers where designer_id='D118'

DELETE FROM collections
WHERE designer_id = 'D118';

ALTER TABLE event_designers
DROP CONSTRAINT FK_event_designers_designer_id;

ALTER TABLE event_designers
ADD CONSTRAINT FK_event_designers_designer_id
FOREIGN KEY (designer_id)
REFERENCES designers(designer_id)
ON DELETE CASCADE;

DELETE FROM designers WHERE designer_id = 'D118';

select * from event_designers where designer_id='D118'

-- to print model details of the models who are not performing in any event 
select model_id, model_firstname, model_lastname, model_age from models where model_id not in (select model_id from event_models)












