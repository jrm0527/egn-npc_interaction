--|--------------------------------------------------------------------------------|--
--|--------------------------------  C O N F I G  ---------------------------------|--
--|--------------------------------------------------------------------------------|--
Config = {}

-- KEYBINDINGS --
modifier = 210 --Default 'Left Control'
kbpomnu = 21 --Default 'Shift' [Pullover keybinding keyboard]
trfmnu = 51 --Default 'E' [Traffic Stop Interaction Menu]
trfcveh = 246 --Default 'Y' [Mimic/Follow Menu]
mainmnu = 303 --Default 'U' [Interaction Menu]

-- OTHER --
reverseWithPlayer = true  --While using mimic, the stopped vehicle will reverse with you, if set to 'false' the stopped vehicle will accelerate when you reverse.
towfadetime = 6

-- TOW OPTIONS --
Config.TowCompanyName = "EGN-Towing"
Config.towOffset = -5.0
Config.deleteLastTruck = true --Deletes the last spawned truck.
Config.spawnDistance = 50 	--	Default 50
							---								---
--Config.drivingStyle = 786603  	--	**786603  - "Normal" - Default**
								--	**1074528293 - "Rushed"**
								--	**2883621 - "Ignore Lights"**
								--	**5 - "Sometimes Overtake Traffic"**
								--	**Customize Driving Style: https://vespura.com/drivingstyle/

local towDriverQuoteOfTheDay = {
	"Howdy partner! I'll get it towed.",
	"Do you even lift bro? Because I do.",
	"You called the right guy, because I got puns from head to tow.",
	"Tow'nt worry about it, I'll get it towed!",
	"I wont charge you a arm and a leg! I only want your tows.",
	"You want too hook up some time?",
	"I hate my job.",
	"Sorry I took so long!",
	"We have some of the best hookers in town!",
	"There ya go!",
	"Take care.",
	"That will look good in the impound!",
	"Fuck you.",
	"I got it!",
	"Thanks for using " .. Config.TowCompanyName .. "!",
	"It will be at the compound."
}

-- POLICE JOBS --
Config.PoliceJobs = { 
    ['police'] = true,
    ['lspd'] = true,
    ['bcso'] = true,
    ['sasp'] = true,
}

-- OFFENSES --
Config.offense = {
	"WANTED BY LSPD",
	"WANTED FOR ASSAULT",
	"WANTED FOR UNPAID FINES",
	"WANTED FOR RUNNING FROM THE POLICE",
	"WANTED FOR EVADING LAW",
	"WANTED FOR HIT AND RUN",
	"WANTED FOR DUI"
}

-- ILLEGAL ITEMS FOUND IN SEARCH --
Config.illegalItems = {
	"a knife.",
	"a pistol.",
	"a fake ID card.",
	"an illegal item.",
	"an empty bottle of beer.",
	"bags with suspicious white powder.",
	"an AK-47.",
	"an armed rifle.",
	"a rifle.",
	"a shotgun.",
	"an UZI.",
	"a weapon."
}

-- MALE NAMES --
Config.malenames = {
	"Tod", "Bud", "Colin", "Nova", "Boyd", "Vivienne", "John", "Donald", "Mike", "Sally", "George", "Sam", "Reuben", "Wade",
	"Arthur", "Raiden", "Camren", "Trystan", "Hugo", "Samir", "Ayaan", "Curtis", "Philip", "Elijah", "Jeffrey", "Frank", "Cedric", "Payton",
	"Ross", "Marshall", "Antwan", "Jamison", "Samuel", "Abram", "Camron", "Luis", "Morgan", "Ronin", "Marcus", "Niko", "Armani", "Jeramiah",
	"Justin", "Uriel", "Jessie", "Alexzander", "Tony", "Remington", "George", "London", "Brent", "Lewis", "Edward", "Davon", "Rigoberto",
	"Denzel", "Jamal", "Demarion", "Reilly", "Atticus", "Micheal", "Clay", "Soren", "Isiah", "Harry", "Aryan", "Asa", "Glenn", "Kasen", "Marvin",
	"Jeremy", "Yusuf", "Luciano", "Sheldon", "Marc", "Brody", "Coleman", "Damari", "Darien", "Layton", "Rafael", "Gregory", "Luka", "Keagan",
	"Zack", "Jan", "Layne", "Keegan", "Augustus", "Clinton", "Jair", "Jairo", "Chaim", "Landyn", "Louis", "Kolby", "Maximus", "Hector", "Javier",
	"Jorge", "Finn", "Demetrius", "Terrence", "Davion", "Jordon", "Cael", "Bradley", "Jayvon", "Marlon", "Axel", "Santiago", "Kade", "Jeffery",
	"Milo", "Alijah", "Addison", "Jasper", "Winston", "Kolton", "Brady", "Bailey", "Damion", "Rocco", "Isaiah", "Nathanial", "Hunter", "Cory",
	"Maurice", "Jean", "Brogan", "Benjamin", "Raul", "Moses", "Kaden", "Blaze", "Trevin", "Gunner", "Lamont", "Jared", "Ben", "Abel", "Dax",
	"Tripp", "Isaias", "Joel", "Deon", "Oswaldo", "Zain", "Korbin", "Aaron", "Allan", "Chad", "Tucker", "Mario", "Isai", "Conor", "Leonard",
	"Owen", "Cyrus", "Deegan", "Jaron", "Pablo", "Cristopher", "Javion", "Leonardo", "Gordon", "Orlando", "William", "Gavin", "Rishi", "Arnav",
	"Jermaine","Bo","Tommy","Issac","Judah","Lincoln","Paxton","Collin","Gerald","King","Oscar","Aron","Blake","Victor","Adriel","Jovanny",
	"Camden","Frederick","Koen","Kaleb","Nikhil","Colby","Emery","Easton","Zion","Callum","Greyson","Ezequiel","Rashad","Pranav","Alex","Jonathon",
	"Urijah","Cristofer","Case","Jaden","Desmond","Colin","Weston","Camryn","Jayvion","Mason","Owen","Ray","Callum","Scotty","Fucking","Cock","Bay",
	"Jeff","Paul","Kanersps","Adam","Jimmy","Garry","Bobby","Arnold","Dick"
}

-- FEMALE NAMES --
Config.femalenames = {
	"Maia","Ebonie","Anne","Elijah","Kathryne","Sheryl","Tomika","Stefanie","Laci","Josefina","Clara","Amy","Mary","Emillia", "Emily","June","Garry",
	"Bob","Jessy","Bailey","Hadley","Kendall","Laci","Lizeth","Ashlynn","Lesly","Lorelei","Meredith","Tanya","Raina", "Cynthia","Eileen","Evie","Lyla",
	"Sonia","Angel","Alexis","Anabella","Layla","Claire","Shania","Aniya","Frida","Celeste","Lindsey","Samara", "Tamia","Luz","Lola","Ryann","Kenya","Cassidy", 
	"Clare","Litzy","Ashlyn","Cheyenne","Ava","Maggie","Kiera","Rayne","Janelle","Reagan","Martha",	"Adeline","Giovanna","Elena","June","Annabella","Abril",
	"Karlie", "Deja","Belinda","Heather","Lea","Myla","Rhianna","Amirah","Selena","Nina","Amaris", "Serenity","Riya","Payton","Cheyanne","Sadie","Dakota","Alison",
	"Mikaela","Jaelyn", "Evelyn","Joanna","Jaslene","Zoie","Paola","Ali","Marlee","Charlee", "Alma","Kamryn","Avery","Aisha","Rachel","Mckenzie","Alissa",
	"Makenzie","Brenna","Virginia","Rosemary", "Wendy","Natasha","Yamilet","Michelle","Maribel", "Elyse","Julissa","Lily","Susan","Hailey","Liberty","Tianna",
	"Bella","Roselyn","Naomi","Kinsley","Cameron","Aracely", "Averi","Eva","Malia","Sara", "Danica","Morgan","Shannon","Raegan","Lyric","Johanna","Melany",
	"Jaqueline","Kennedi","Amy","Chanel","Kaliyah","Zoe","Kaylyn","Chaya", "Julie", "Alivia", "Karissa","Eliza","Kiana","Thalia","Sarahi","Samantha","Noelle",
	"Vivian","Desirae","Dayanara","Aryanna","Teresa","Jordan","Camryn","Ariella","Chana", "Sidney","Hana","Princess","Kayley","Jaida","April","Genevieve",
	"Kathryn","Violet","Marlie","Iliana","Kallie","Isla","Cecilia","Stacy","Phoenix", "Eliana","Mylie","Amani","Sanaa","Giuliana","Maleah","Amanda","Norah",
	"Gwendolyn","Bailee","Brooklyn","Leia","Amari","Margaret","Kaia","Breanna", "Rose","Leslie","Aylin","Celia","Alia","Kasey","Azul","Halle","Tara","Miracle",
	"Shirley","Katrina","Shiloh","Catherine","Addison","Laurel","Jaylah", "Heidy","Anabel","Madalyn","Shelby","Saige","Carleigh","Kaelyn","Mommy","Kitchen","Woman","Emma"
}

-- RANDOM NAMES --
Config.firstnames = {"Tod","Bud","Colin","Nova","Boyd","Vivienne","John","Donald","Mike","Sally","George","Sam","Reuben","Wade","Arthur","Raiden","Camren",
	"Trystan","Hugo","Samir","Ayaan","Curtis","Philip","Elijah","Jeffrey","Frank","Cedric","Payton","Ross","Marshall","Antwan","Jamison","Samuel","Abram",
	"Camron","Luis","Morgan","Ronin","Marcus","Niko","Armani","Jeramiah","Justin","Uriel","Jessie","Alexzander","Tony","Remington","George","London",
	"Brent","Lewis","Edward","Davon","Rigoberto","Denzel","Jamal","Demarion","Reilly","Atticus","Micheal","Clay","Soren","Isiah","Harry","Aryan","Asa",
	"Glenn","Kasen","Marvin","Jeremy","Yusuf","Luciano","Sheldon","Marc","Brody","Coleman","Damari","Darien","Layton","Rafael","Gregory","Luka","Keagan",
	"Zack","Jan","Layne","Keegan","Augustus","Clinton","Jair","Jairo","Chaim","Landyn","Louis","Kolby","Maximus","Hector","Javier","Jorge","Finn","Demetrius",
	"Terrence","Davion","Jordon","Cael","Bradley","Jayvon","Marlon","Axel","Santiago","Kade","Jeffery","Milo","Alijah","Addison","Jasper","Winston","Kolton",
	"Brady","Bailey","Damion","Rocco","Isaiah","Nathanial","Hunter","Cory","Maurice","Jean","Brogan","Benjamin","Raul","Moses","Kaden","Blaze","Trevin","Gunner",
	"Lamont","Jared","Ben","Abel","Dax","Tripp","Isaias","Joel","Deon","Oswaldo","Zain","Korbin","Aaron","Allan","Chad","Tucker","Mario","Isai","Conor","Leonard",
	"Owen","Cyrus","Deegan","Jaron","Pablo","Cristopher","Javion","Leonardo","Gordon","Orlando","William","Gavin","Rishi","Arnav","Jermaine","Bo","Tommy","Issac",
	"Judah","Lincoln","Paxton","Collin","Gerald","King","Oscar","Aron","Blake","Victor","Adriel","Jovanny","Camden","Frederick","Koen","Kaleb","Nikhil","Colby",
	"Emery","Easton","Zion","Callum","Greyson","Ezequiel","Rashad","Pranav","Alex","Jonathon","Urijah","Cristofer","Case","Jaden","Desmond","Colin","Weston","Camryn",
	"Jayvion","Mason","Owen","Ray","Callum","Scotty","Fucking","Cock","Bay","Jeff","Paul","Kanersps","Adam","Jimmy","Garry","Bobby","Arnold","Dick","Maia","Ebonie",
	"Anne","Elijah","Kathryne","Sheryl","Tomika","Stefanie","Laci","Josefina","Clara","Amy","Mary","Emillia","Emily","June","Garry","Bob","Jessy","Bailey","Hadley",
	"Kendall","Laci","Lizeth","Ashlynn","Lesly","Lorelei","Meredith","Tanya","Raina","Cynthia","Eileen","Evie","Lyla","Sonia","Angel","Alexis","Anabella","Layla","Claire",
	"Shania","Aniya","Frida","Celeste","Lindsey","Samara","Tamia","Luz","Lola","Ryann","Kenya","Cassidy","Clare","Litzy","Ashlyn","Cheyenne","Ava","Maggie","Kiera",
	"Rayne","Janelle","Reagan","Martha","Adeline","Giovanna","Elena","June","Annabella","Abril","Karlie","Deja","Belinda","Heather","Lea","Myla","Rhianna","Amirah",
	"Selena","Nina","Amaris","Serenity","Riya","Payton","Cheyanne","Sadie","Dakota","Alison","Mikaela","Jaelyn","Evelyn","Joanna","Jaslene","Zoie","Paola","Ali","Marlee",
	"Charlee","Alma","Kamryn","Avery","Aisha","Rachel","Mckenzie","Alissa","Makenzie","Brenna","Virginia","Rosemary","Wendy","Natasha","Yamilet","Michelle","Maribel",
	"Elyse","Julissa","Lily","Susan","Hailey","Liberty","Tianna","Bella","Roselyn","Naomi","Kinsley","Cameron","Aracely","Averi","Eva","Malia","Sara","Danica","Morgan",
	"Shannon","Raegan","Lyric","Johanna","Melany","Jaqueline","Kennedi","Amy","Chanel","Kaliyah","Zoe","Kaylyn","Chaya","Julie","Alivia","Karissa","Eliza","Kiana",
	"Thalia","Sarahi","Samantha","Noelle","Vivian","Desirae","Dayanara","Aryanna","Teresa","Jordan","Camryn","Ariella","Chana","Sidney","Hana","Princess","Kayley",
	"Jaida","April","Genevieve","Kathryn","Violet","Marlie","Iliana","Kallie","Isla","Cecilia","Stacy","Phoenix","Eliana","Mylie","Amani","Sanaa","Giuliana","Maleah",
	"Amanda","Norah","Gwendolyn","Bailee","Brooklyn","Leia","Amari","Margaret","Kaia","Breanna","Rose","Leslie","Aylin","Celia","Alia","Kasey","Azul","Halle","Tara",
	"Miracle","Shirley","Katrina","Shiloh","Catherine","Addison","Laurel","Jaylah","Heidy","Anabel","Madalyn","Shelby","Saige","Carleigh","Kaelyn","Mommy","Kitchen",
	"Woman","Emma"
}

-- LAST NAMES --
Config.lastnames = {"Hansen","Malone","Barnett","Cooper","Sosa","Castaneda","Quinn","Stanton","Orozco","Salazar","Gonzalez","Hull","Colon","Vincent","Poole","Good",
	"Serrano","Lozano","Hancock","Travis","Ortega","Mcguire","Carney","Velasquez","Moore","Rosales","Cross","Mullins","Hahn","Carlson","Chase","Glass","Walter","Holmes",
	"Rivera","Medina","Perez","Carson","King","Lloyd","Christian","Franklin","Bautista","Ball","Bowers","Sampson","Harmon","Hutchinson","Rogers","Knight","Sullivan",
	"Christensen","Lindsey","Cantrell","Rush","Reid","Hawkins","Ferrell","Li","Sheppard","Clay","Riley","Blevins","Forbes","Raymond","Hodge","Austin","Skinner","Walsh",
	"Bridges","Jacobson","Wilson","Pacheco","Moss","Randolph","Hoffman","Gilmore","Bryan","Deleon","Oneal","Church","Curtis","Santana","Bruce","Woods","Klein","Vaughan",
	"Solomon","Maxwell","Downs","Strong","Mcmahon","Suarez","Mccall","Ewing","Barron","Zamora","Webster","Hinton","Vargas","Robbins","Roman","Reeves","Douglas","Reilly",
	"Blair","Glover","Arnold","Tran","Maynard","Cuevas","Todd","Kramer","Yoder","Conway","Owens","Wu","Fritz","Hoover","Vance","Green","Frederick","Vega","Osborn","Buck",
	"Pratt","Trujillo","Cortez","Mcclain","Richmond","Krueger","Mayo","Mahoney","Hartman","Bowman","Arias","Boyle","Simmons","Bush","Davenport","Roberts","Ochoa","Chang",
	"Luna","Villegas","Rios","Dodson","Johnston","Shah","Guerrero","Stuart","Rocha","Landry","Estes","Fleming","Davila","Merritt","Love","Petersen","Callahan","Robertson",
	"Hood","Frank","Duke","Lawson","Stevens","Whitney","Benitez","Payne","Gibson","Castillo","Greer","Henson","Dougherty","Nunez","Wells","Wallace","Byrd","Doyle",
	"Goodman","Webb","Ortiz","Houston","Sanchez","Duarte","Mccoy","Lam","Monroe","Carroll","Nash","Parks","Peters","Sutton","Atkins","Bonilla","Mcclure","Leonard",
	"Murphy","Davidson","Harrington","Whitehead","Le","Vazquez","Tucker","Gallagher","Wiley","Larson","Mcconnell","Chandler","Pierce","Salas","Day","Taylor","Shields",
	"Mcdonald","Fowler","Neal","Wall","Murillo","Hopkins","Macdonald","Banks","Acevedo","Bauer","Weeks","Summers","Saunders","Stevenson","Newton","Kent","Sellers","Barber",
	"Rubio","Mejia","Fischer","Thomas","Mccarty","Carter","Duran","Short","Watkins","Meyers","Kirby","Velazquez","Bright","Rivas","Mcneil","Caldwell","Santiago",
	"Zavala","Perkins","Khan","Miller","Ward","Small","Gilbert","Nixon","Cochran","Blackburn","Gates","Stafford","Stein","Wilcox","Morgan","Lyons","Lynn","Cannon","Yates",
	"Wise","Olsen","White","Holt","Riggs","Bond","Heath","Schmitt","Willis","Turner","Ibarra","Burns","Anthony","Weber","Daniels","Higgins","Mayer","Burch","Garner",
	"Trevino","Avila","Woodward","Bray","Fuentes","Terrell","Porter","Mathis","Garrison","Stokes","Marsh","Bailey","Allen","Marshall","Richard","Huffman","Roach","Murray",
	"Preston","Lucas","Mccarthy","Francis","Esparza","Powell","Dunlap","Norman","Crosby","Holland","Brandt","Finley","Delacruz","Romero","Ayala","Pollard","Madden",
	"Irwin","Armstrong","Frye","Mora","Osborne","Wood","Gibbs","Glenn","Hunt","Winters","Bell","Morris","Key","Wolf","Garrett","Rodriguez","Pope","Fisher","Mcintyre",
	"Tyler","Rodgers","Hill","Macias","Brennan","Hines","Conley","Jennings","Ayers","Hernandez","Cole","Beck","Odonnell","Zhang","Hunter","Waller","Cowan","Valentine",
	"Underwood","Donaldson","Bolton","Steele","Wheeler","George","Hester","Richards","Sandoval","Grant","Franco","Everett","Gay","Knox","Sexton","Coleman","Gregory","Young",
	"Pineda","Howard","Combs","Villa","Padilla","Huerta","Hughes","Werner","Kim","Barajas","Pearson","Chan","Robles","Carey","Joseph","Patrick","Lewis","Cantu","Donovan",
	"Rose","Harvey","Strickland","Hammond","Fox","Wiley","Terry","Mendoza","Maldonado","Garrison","Waters","Weber","Pena","Macdonald","Allison","Thompson","Ramsey",
	"Mosley","Hester","Bowman","Blake","Caldwell","Villegas","Case","Moran","Welch","Ortiz","Pham","Mcclure","Reid","Orr","Poole","Rivera","King","Powell","Burns","Salas",
	"Velazquez","Huang","Collins","Pollard","Alvarado","Campbell","Merritt","May","Ford","Wilkins","Durham","Olsen","Barnett","Mahoney","Norman","Nash","Davis","Morton",
	"Woodman","Markozov","Thomas","Hughes","Cena","Gobbler"
}

-- CAR TYPES --
Config.carType = {[0]="Compact",[1]="Sedan",[2]="SUV",[3]="Coupe",[4]="Muscle",[5]="Sports Classic",[6]="Sports",[7]="Super",
	[8]="Motorcycle",[9]="Off-road",[10]="Industrial",[11]="Utilty",[12]="Van",[13]="Cycle",[14]="Boat",[15]="Helicopter",
	[16]="Plane",[17]="Service",[18]="Emergency",[19]="Military",[20]="Commerecial",[21]="Train",
}