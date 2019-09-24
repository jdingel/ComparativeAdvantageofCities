
cap program drop IPUMS_data_1980
program IPUMS_data_1980

set more off

clear
quietly infix              ///
  int     year      1-4    ///
  byte    datanum   5-6    ///
  double  serial    7-14   ///
  double  hhwt      15-24  ///
  byte    statefip  25-26  ///
  int     metarea   27-29  ///
  int     metaread  30-33  ///
  byte    gq        34-34  ///
  int     pernum    35-38  ///
  double  perwt     39-48  ///
  byte    sex       49-49  ///
  int     age       50-52  ///
  byte    race      53-53  ///
  int     raced     54-56  ///
  byte    hispan    57-57  ///
  int     hispand   58-60  ///
  int     bpl       61-63  ///
  long    bpld      64-68  ///
  byte    educ      69-70  ///
  int     educd     71-73  ///
  byte    empstat   74-74  ///
  byte    empstatd  75-76  ///
  byte    labforce  77-77  ///
  byte    wkswork1  78-79  ///
  byte    uhrswork  80-81  ///
  long    incwage   82-87  ///
  using `"../input/IPUMS_1980.dat"'

replace hhwt     = hhwt     / 100
replace perwt    = perwt    / 100

format serial   %8.0g
format hhwt     %10.2f
format perwt    %10.2f

label var year     `"Census year"'
label var datanum  `"Data set number"'
label var serial   `"Household serial number"'
label var hhwt     `"Household weight"'
label var statefip `"State (FIPS code)"'
label var metarea  `"Metropolitan area [general version]"'
label var metaread `"Metropolitan area [detailed version]"'
label var gq       `"Group quarters status"'
label var pernum   `"Person number in sample unit"'
label var perwt    `"Person weight"'
label var sex      `"Sex"'
label var age      `"Age"'
label var race     `"Race [general version]"'
label var raced    `"Race [detailed version]"'
label var hispan   `"Hispanic origin [general version]"'
label var hispand  `"Hispanic origin [detailed version]"'
label var bpl      `"Birthplace [general version]"'
label var bpld     `"Birthplace [detailed version]"'
label var educ     `"Educational attainment [general version]"'
label var educd    `"Educational attainment [detailed version]"'
label var empstat  `"Employment status [general version]"'
label var empstatd `"Employment status [detailed version]"'
label var labforce `"Labor force status"'
label var wkswork1 `"Weeks worked last year"'
label var uhrswork `"Usual hours worked per week"'
label var incwage  `"Wage and salary income"'

label define year_lbl 1850 `"1850"'
label define year_lbl 1860 `"1860"', add
label define year_lbl 1870 `"1870"', add
label define year_lbl 1880 `"1880"', add
label define year_lbl 1900 `"1900"', add
label define year_lbl 1910 `"1910"', add
label define year_lbl 1920 `"1920"', add
label define year_lbl 1930 `"1930"', add
label define year_lbl 1940 `"1940"', add
label define year_lbl 1950 `"1950"', add
label define year_lbl 1960 `"1960"', add
label define year_lbl 1970 `"1970"', add
label define year_lbl 1980 `"1980"', add
label define year_lbl 1990 `"1990"', add
label define year_lbl 2000 `"2000"', add
label define year_lbl 2001 `"2001"', add
label define year_lbl 2002 `"2002"', add
label define year_lbl 2003 `"2003"', add
label define year_lbl 2004 `"2004"', add
label define year_lbl 2005 `"2005"', add
label define year_lbl 2006 `"2006"', add
label define year_lbl 2007 `"2007"', add
label define year_lbl 2008 `"2008"', add
label define year_lbl 2009 `"2009"', add
label define year_lbl 2010 `"2010"', add
label define year_lbl 2011 `"2011"', add
label define year_lbl 2012 `"2012"', add
label define year_lbl 2013 `"2013"', add
label define year_lbl 2014 `"2014"', add
label define year_lbl 2015 `"2015"', add
label define year_lbl 2016 `"2016"', add
label define year_lbl 2017 `"2017"', add
label values year year_lbl

label define statefip_lbl 01 `"Alabama"'
label define statefip_lbl 02 `"Alaska"', add
label define statefip_lbl 04 `"Arizona"', add
label define statefip_lbl 05 `"Arkansas"', add
label define statefip_lbl 06 `"California"', add
label define statefip_lbl 08 `"Colorado"', add
label define statefip_lbl 09 `"Connecticut"', add
label define statefip_lbl 10 `"Delaware"', add
label define statefip_lbl 11 `"District of Columbia"', add
label define statefip_lbl 12 `"Florida"', add
label define statefip_lbl 13 `"Georgia"', add
label define statefip_lbl 15 `"Hawaii"', add
label define statefip_lbl 16 `"Idaho"', add
label define statefip_lbl 17 `"Illinois"', add
label define statefip_lbl 18 `"Indiana"', add
label define statefip_lbl 19 `"Iowa"', add
label define statefip_lbl 20 `"Kansas"', add
label define statefip_lbl 21 `"Kentucky"', add
label define statefip_lbl 22 `"Louisiana"', add
label define statefip_lbl 23 `"Maine"', add
label define statefip_lbl 24 `"Maryland"', add
label define statefip_lbl 25 `"Massachusetts"', add
label define statefip_lbl 26 `"Michigan"', add
label define statefip_lbl 27 `"Minnesota"', add
label define statefip_lbl 28 `"Mississippi"', add
label define statefip_lbl 29 `"Missouri"', add
label define statefip_lbl 30 `"Montana"', add
label define statefip_lbl 31 `"Nebraska"', add
label define statefip_lbl 32 `"Nevada"', add
label define statefip_lbl 33 `"New Hampshire"', add
label define statefip_lbl 34 `"New Jersey"', add
label define statefip_lbl 35 `"New Mexico"', add
label define statefip_lbl 36 `"New York"', add
label define statefip_lbl 37 `"North Carolina"', add
label define statefip_lbl 38 `"North Dakota"', add
label define statefip_lbl 39 `"Ohio"', add
label define statefip_lbl 40 `"Oklahoma"', add
label define statefip_lbl 41 `"Oregon"', add
label define statefip_lbl 42 `"Pennsylvania"', add
label define statefip_lbl 44 `"Rhode Island"', add
label define statefip_lbl 45 `"South Carolina"', add
label define statefip_lbl 46 `"South Dakota"', add
label define statefip_lbl 47 `"Tennessee"', add
label define statefip_lbl 48 `"Texas"', add
label define statefip_lbl 49 `"Utah"', add
label define statefip_lbl 50 `"Vermont"', add
label define statefip_lbl 51 `"Virginia"', add
label define statefip_lbl 53 `"Washington"', add
label define statefip_lbl 54 `"West Virginia"', add
label define statefip_lbl 55 `"Wisconsin"', add
label define statefip_lbl 56 `"Wyoming"', add
label define statefip_lbl 61 `"Maine-New Hampshire-Vermont"', add
label define statefip_lbl 62 `"Massachusetts-Rhode Island"', add
label define statefip_lbl 63 `"Minnesota-Iowa-Missouri-Kansas-Nebraska-S.Dakota-N.Dakota"', add
label define statefip_lbl 64 `"Maryland-Delaware"', add
label define statefip_lbl 65 `"Montana-Idaho-Wyoming"', add
label define statefip_lbl 66 `"Utah-Nevada"', add
label define statefip_lbl 67 `"Arizona-New Mexico"', add
label define statefip_lbl 68 `"Alaska-Hawaii"', add
label define statefip_lbl 72 `"Puerto Rico"', add
label define statefip_lbl 97 `"Military/Mil. Reservation"', add
label define statefip_lbl 99 `"State not identified"', add
label values statefip statefip_lbl

label define metarea_lbl 000 `"Not identifiable or not in an MSA"'
label define metarea_lbl 004 `"Abilene, TX"', add
label define metarea_lbl 006 `"Aguadilla, PR"', add
label define metarea_lbl 008 `"Akron, OH"', add
label define metarea_lbl 012 `"Albany, GA"', add
label define metarea_lbl 016 `"Albany-Schenectady-Troy, NY"', add
label define metarea_lbl 020 `"Albuquerque, NM"', add
label define metarea_lbl 022 `"Alexandria, LA"', add
label define metarea_lbl 024 `"Allentown-Bethlehem-Easton, PA/NJ"', add
label define metarea_lbl 028 `"Altoona, PA"', add
label define metarea_lbl 032 `"Amarillo, TX"', add
label define metarea_lbl 038 `"Anchorage, AK"', add
label define metarea_lbl 040 `"Anderson, IN"', add
label define metarea_lbl 044 `"Ann Arbor, MI"', add
label define metarea_lbl 045 `"Anniston, AL"', add
label define metarea_lbl 046 `"Appleton-Oshkosh-Neenah, WI"', add
label define metarea_lbl 047 `"Arecibo, PR"', add
label define metarea_lbl 048 `"Asheville, NC"', add
label define metarea_lbl 050 `"Athens, GA"', add
label define metarea_lbl 052 `"Atlanta, GA"', add
label define metarea_lbl 056 `"Atlantic City, NJ"', add
label define metarea_lbl 058 `"Auburn-Opekika, AL"', add
label define metarea_lbl 060 `"Augusta-Aiken, GA/SC"', add
label define metarea_lbl 064 `"Austin, TX"', add
label define metarea_lbl 068 `"Bakersfield, CA"', add
label define metarea_lbl 072 `"Baltimore, MD"', add
label define metarea_lbl 073 `"Bangor, ME"', add
label define metarea_lbl 074 `"Barnstable-Yarmouth, MA"', add
label define metarea_lbl 076 `"Baton Rouge, LA"', add
label define metarea_lbl 078 `"Battle Creek, MI"', add
label define metarea_lbl 084 `"Beaumont-Port Arthur-Orange, TX"', add
label define metarea_lbl 086 `"Bellingham, WA"', add
label define metarea_lbl 087 `"Benton Harbor, MI"', add
label define metarea_lbl 088 `"Billings, MT"', add
label define metarea_lbl 092 `"Biloxi-Gulfport, MS"', add
label define metarea_lbl 096 `"Binghamton, NY"', add
label define metarea_lbl 100 `"Birmingham, AL"', add
label define metarea_lbl 102 `"Bloomington, IN"', add
label define metarea_lbl 104 `"Bloomington-Normal, IL"', add
label define metarea_lbl 108 `"Boise City, ID"', add
label define metarea_lbl 112 `"Boston, MA/NH"', add
label define metarea_lbl 114 `"Bradenton, FL"', add
label define metarea_lbl 115 `"Bremerton, WA"', add
label define metarea_lbl 116 `"Bridgeport, CT"', add
label define metarea_lbl 120 `"Brockton, MA"', add
label define metarea_lbl 124 `"Brownsville-Harlingen-San Benito, TX"', add
label define metarea_lbl 126 `"Bryan-College Station, TX"', add
label define metarea_lbl 128 `"Buffalo-Niagara Falls, NY"', add
label define metarea_lbl 130 `"Burlington, NC"', add
label define metarea_lbl 131 `"Burlington, VT"', add
label define metarea_lbl 132 `"Canton, OH"', add
label define metarea_lbl 133 `"Caguas, PR"', add
label define metarea_lbl 135 `"Casper, WY"', add
label define metarea_lbl 136 `"Cedar Rapids, IA"', add
label define metarea_lbl 140 `"Champaign-Urbana-Rantoul, IL"', add
label define metarea_lbl 144 `"Charleston-N. Charleston, SC"', add
label define metarea_lbl 148 `"Charleston, WV"', add
label define metarea_lbl 152 `"Charlotte-Gastonia-Rock Hill, NC/SC"', add
label define metarea_lbl 154 `"Charlottesville, VA"', add
label define metarea_lbl 156 `"Chattanooga, TN/GA"', add
label define metarea_lbl 158 `"Cheyenne, WY"', add
label define metarea_lbl 160 `"Chicago, IL"', add
label define metarea_lbl 162 `"Chico, CA"', add
label define metarea_lbl 164 `"Cincinnati-Hamilton, OH/KY/IN"', add
label define metarea_lbl 166 `"Clarksville- Hopkinsville, TN/KY"', add
label define metarea_lbl 168 `"Cleveland, OH"', add
label define metarea_lbl 172 `"Colorado Springs, CO"', add
label define metarea_lbl 174 `"Columbia, MO"', add
label define metarea_lbl 176 `"Columbia, SC"', add
label define metarea_lbl 180 `"Columbus, GA/AL"', add
label define metarea_lbl 184 `"Columbus, OH"', add
label define metarea_lbl 188 `"Corpus Christi, TX"', add
label define metarea_lbl 190 `"Cumberland, MD/WV"', add
label define metarea_lbl 192 `"Dallas-Fort Worth, TX"', add
label define metarea_lbl 193 `"Danbury, CT"', add
label define metarea_lbl 195 `"Danville, VA"', add
label define metarea_lbl 196 `"Davenport, IA - Rock Island-Moline, IL"', add
label define metarea_lbl 200 `"Dayton-Springfield, OH"', add
label define metarea_lbl 202 `"Daytona Beach, FL"', add
label define metarea_lbl 203 `"Decatur, AL"', add
label define metarea_lbl 204 `"Decatur, IL"', add
label define metarea_lbl 208 `"Denver-Boulder, CO"', add
label define metarea_lbl 212 `"Des Moines, IA"', add
label define metarea_lbl 216 `"Detroit, MI"', add
label define metarea_lbl 218 `"Dothan, AL"', add
label define metarea_lbl 219 `"Dover, DE"', add
label define metarea_lbl 220 `"Dubuque, IA"', add
label define metarea_lbl 224 `"Duluth-Superior, MN/WI"', add
label define metarea_lbl 228 `"Dutchess Co., NY"', add
label define metarea_lbl 229 `"Eau Claire, WI"', add
label define metarea_lbl 231 `"El Paso, TX"', add
label define metarea_lbl 232 `"Elkhart-Goshen, IN"', add
label define metarea_lbl 233 `"Elmira, NY"', add
label define metarea_lbl 234 `"Enid, OK"', add
label define metarea_lbl 236 `"Erie, PA"', add
label define metarea_lbl 240 `"Eugene-Springfield, OR"', add
label define metarea_lbl 244 `"Evansville, IN/KY"', add
label define metarea_lbl 252 `"Fargo-Morehead, ND/MN"', add
label define metarea_lbl 256 `"Fayetteville, NC"', add
label define metarea_lbl 258 `"Fayetteville-Springdale, AR"', add
label define metarea_lbl 260 `"Fitchburg-Leominster, MA"', add
label define metarea_lbl 262 `"Flagstaff, AZ/UT"', add
label define metarea_lbl 264 `"Flint, MI"', add
label define metarea_lbl 265 `"Florence, AL"', add
label define metarea_lbl 266 `"Florence, SC"', add
label define metarea_lbl 267 `"Fort Collins-Loveland, CO"', add
label define metarea_lbl 268 `"Fort Lauderdale-Hollywood-Pompano Beach, FL"', add
label define metarea_lbl 270 `"Fort Myers-Cape Coral, FL"', add
label define metarea_lbl 271 `"Fort Pierce, FL"', add
label define metarea_lbl 272 `"Fort Smith, AR/OK"', add
label define metarea_lbl 275 `"Fort Walton Beach, FL"', add
label define metarea_lbl 276 `"Fort Wayne, IN"', add
label define metarea_lbl 284 `"Fresno, CA"', add
label define metarea_lbl 288 `"Gadsden, AL"', add
label define metarea_lbl 290 `"Gainesville, FL"', add
label define metarea_lbl 292 `"Galveston-Texas City, TX"', add
label define metarea_lbl 297 `"Glens Falls, NY"', add
label define metarea_lbl 298 `"Goldsboro, NC"', add
label define metarea_lbl 299 `"Grand Forks, ND"', add
label define metarea_lbl 300 `"Grand Rapids, MI"', add
label define metarea_lbl 301 `"Grand Junction, CO"', add
label define metarea_lbl 304 `"Great Falls, MT"', add
label define metarea_lbl 306 `"Greeley, CO"', add
label define metarea_lbl 308 `"Green Bay, WI"', add
label define metarea_lbl 312 `"Greensboro-Winston Salem-High Point, NC"', add
label define metarea_lbl 315 `"Greenville, NC"', add
label define metarea_lbl 316 `"Greenville-Spartenburg-Anderson, SC"', add
label define metarea_lbl 318 `"Hagerstown, MD"', add
label define metarea_lbl 320 `"Hamilton-Middleton, OH"', add
label define metarea_lbl 324 `"Harrisburg-Lebanon--Carlisle, PA"', add
label define metarea_lbl 328 `"Hartford-Bristol-Middleton- New Britain, CT"', add
label define metarea_lbl 329 `"Hickory-Morganton, NC"', add
label define metarea_lbl 330 `"Hattiesburg, MS"', add
label define metarea_lbl 332 `"Honolulu, HI"', add
label define metarea_lbl 335 `"Houma-Thibodoux, LA"', add
label define metarea_lbl 336 `"Houston-Brazoria, TX"', add
label define metarea_lbl 340 `"Huntington-Ashland, WV/KY/OH"', add
label define metarea_lbl 344 `"Huntsville, AL"', add
label define metarea_lbl 348 `"Indianapolis, IN"', add
label define metarea_lbl 350 `"Iowa City, IA"', add
label define metarea_lbl 352 `"Jackson, MI"', add
label define metarea_lbl 356 `"Jackson, MS"', add
label define metarea_lbl 358 `"Jackson, TN"', add
label define metarea_lbl 359 `"Jacksonville, FL"', add
label define metarea_lbl 360 `"Jacksonville, NC"', add
label define metarea_lbl 361 `"Jamestown-Dunkirk, NY"', add
label define metarea_lbl 362 `"Janesville-Beloit, WI"', add
label define metarea_lbl 366 `"Johnson City-Kingsport--Bristol, TN/VA"', add
label define metarea_lbl 368 `"Johnstown, PA"', add
label define metarea_lbl 371 `"Joplin, MO"', add
label define metarea_lbl 372 `"Kalamazoo-Portage, MI"', add
label define metarea_lbl 374 `"Kankakee, IL"', add
label define metarea_lbl 376 `"Kansas City, MO/KS"', add
label define metarea_lbl 380 `"Kenosha, WI"', add
label define metarea_lbl 381 `"Kileen-Temple, TX"', add
label define metarea_lbl 384 `"Knoxville, TN"', add
label define metarea_lbl 385 `"Kokomo, IN"', add
label define metarea_lbl 387 `"LaCrosse, WI"', add
label define metarea_lbl 388 `"Lafayette, LA"', add
label define metarea_lbl 392 `"Lafayette-W. Lafayette, IN"', add
label define metarea_lbl 396 `"Lake Charles, LA"', add
label define metarea_lbl 398 `"Lakeland-Winterhaven, FL"', add
label define metarea_lbl 400 `"Lancaster, PA"', add
label define metarea_lbl 404 `"Lansing-E. Lansing, MI"', add
label define metarea_lbl 408 `"Laredo, TX"', add
label define metarea_lbl 410 `"Las Cruces, NM"', add
label define metarea_lbl 412 `"Las Vegas, NV"', add
label define metarea_lbl 415 `"Lawrence, KS"', add
label define metarea_lbl 420 `"Lawton, OK"', add
label define metarea_lbl 424 `"Lewiston-Auburn, ME"', add
label define metarea_lbl 428 `"Lexington-Fayette, KY"', add
label define metarea_lbl 432 `"Lima, OH"', add
label define metarea_lbl 436 `"Lincoln, NE"', add
label define metarea_lbl 440 `"Little Rock-N. Little Rock, AR"', add
label define metarea_lbl 441 `"Long Branch-Asbury Park, NJ"', add
label define metarea_lbl 442 `"Longview-Marshall, TX"', add
label define metarea_lbl 444 `"Lorain-Elyria, OH"', add
label define metarea_lbl 448 `"Los Angeles-Long Beach, CA"', add
label define metarea_lbl 452 `"Louisville, KY/IN"', add
label define metarea_lbl 460 `"Lubbock, TX"', add
label define metarea_lbl 464 `"Lynchburg, VA"', add
label define metarea_lbl 468 `"Macon-Warner Robins, GA"', add
label define metarea_lbl 472 `"Madison, WI"', add
label define metarea_lbl 476 `"Manchester, NH"', add
label define metarea_lbl 480 `"Mansfield, OH"', add
label define metarea_lbl 484 `"Mayaguez, PR"', add
label define metarea_lbl 488 `"McAllen-Edinburg-Pharr-Mission, TX"', add
label define metarea_lbl 489 `"Medford, OR"', add
label define metarea_lbl 490 `"Melbourne-Titusville-Cocoa-Palm Bay, FL"', add
label define metarea_lbl 492 `"Memphis, TN/AR/MS"', add
label define metarea_lbl 494 `"Merced, CA"', add
label define metarea_lbl 500 `"Miami-Hialeah, FL"', add
label define metarea_lbl 504 `"Midland, TX"', add
label define metarea_lbl 508 `"Milwaukee, WI"', add
label define metarea_lbl 512 `"Minneapolis-St. Paul, MN"', add
label define metarea_lbl 514 `"Missoula, MT"', add
label define metarea_lbl 516 `"Mobile, AL"', add
label define metarea_lbl 517 `"Modesto, CA"', add
label define metarea_lbl 519 `"Monmouth-Ocean, NJ"', add
label define metarea_lbl 520 `"Monroe, LA"', add
label define metarea_lbl 524 `"Montgomery, AL"', add
label define metarea_lbl 528 `"Muncie, IN"', add
label define metarea_lbl 532 `"Muskegon-Norton Shores-Muskegon Heights, MI"', add
label define metarea_lbl 533 `"Myrtle Beach, SC"', add
label define metarea_lbl 534 `"Naples, FL"', add
label define metarea_lbl 535 `"Nashua, NH"', add
label define metarea_lbl 536 `"Nashville, TN"', add
label define metarea_lbl 540 `"New Bedford, MA"', add
label define metarea_lbl 546 `"New Brunswick-Perth Amboy-Sayreville, NJ"', add
label define metarea_lbl 548 `"New Haven-Meriden, CT"', add
label define metarea_lbl 552 `"New London-Norwich, CT/RI"', add
label define metarea_lbl 556 `"New Orleans, LA"', add
label define metarea_lbl 560 `"New York, NY-Northeastern NJ"', add
label define metarea_lbl 564 `"Newark, OH"', add
label define metarea_lbl 566 `"Newburgh-Middletown, NY"', add
label define metarea_lbl 572 `"Norfolk-VA Beach--Newport News, VA"', add
label define metarea_lbl 576 `"Norwalk, CT"', add
label define metarea_lbl 579 `"Ocala, FL"', add
label define metarea_lbl 580 `"Odessa, TX"', add
label define metarea_lbl 588 `"Oklahoma City, OK"', add
label define metarea_lbl 591 `"Olympia, WA"', add
label define metarea_lbl 592 `"Omaha, NE/IA"', add
label define metarea_lbl 595 `"Orange, NY"', add
label define metarea_lbl 596 `"Orlando, FL"', add
label define metarea_lbl 599 `"Owensboro, KY"', add
label define metarea_lbl 601 `"Panama City, FL"', add
label define metarea_lbl 602 `"Parkersburg-Marietta,WV/OH"', add
label define metarea_lbl 603 `"Pascagoula-Moss Point, MS"', add
label define metarea_lbl 608 `"Pensacola, FL"', add
label define metarea_lbl 612 `"Peoria, IL"', add
label define metarea_lbl 616 `"Philadelphia, PA/NJ"', add
label define metarea_lbl 620 `"Phoenix, AZ"', add
label define metarea_lbl 628 `"Pittsburgh, PA"', add
label define metarea_lbl 632 `"Pittsfield, MA"', add
label define metarea_lbl 636 `"Ponce, PR"', add
label define metarea_lbl 640 `"Portland, ME"', add
label define metarea_lbl 644 `"Portland, OR/WA"', add
label define metarea_lbl 645 `"Portsmouth-Dover--Rochester, NH/ME"', add
label define metarea_lbl 646 `"Poughkeepsie, NY"', add
label define metarea_lbl 648 `"Providence-Fall River-Pawtucket, MA/RI"', add
label define metarea_lbl 652 `"Provo-Orem, UT"', add
label define metarea_lbl 656 `"Pueblo, CO"', add
label define metarea_lbl 658 `"Punta Gorda, FL"', add
label define metarea_lbl 660 `"Racine, WI"', add
label define metarea_lbl 664 `"Raleigh-Durham, NC"', add
label define metarea_lbl 666 `"Rapid City, SD"', add
label define metarea_lbl 668 `"Reading, PA"', add
label define metarea_lbl 669 `"Redding, CA"', add
label define metarea_lbl 672 `"Reno, NV"', add
label define metarea_lbl 674 `"Richland-Kennewick-Pasco, WA"', add
label define metarea_lbl 676 `"Richmond-Petersburg, VA"', add
label define metarea_lbl 678 `"Riverside-San Bernardino, CA"', add
label define metarea_lbl 680 `"Roanoke, VA"', add
label define metarea_lbl 682 `"Rochester, MN"', add
label define metarea_lbl 684 `"Rochester, NY"', add
label define metarea_lbl 688 `"Rockford, IL"', add
label define metarea_lbl 689 `"Rocky Mount, NC"', add
label define metarea_lbl 692 `"Sacramento, CA"', add
label define metarea_lbl 696 `"Saginaw-Bay City-Midland, MI"', add
label define metarea_lbl 698 `"St. Cloud, MN"', add
label define metarea_lbl 700 `"St. Joseph, MO"', add
label define metarea_lbl 704 `"St. Louis, MO/IL"', add
label define metarea_lbl 708 `"Salem, OR"', add
label define metarea_lbl 712 `"Salinas-Sea Side-Monterey, CA"', add
label define metarea_lbl 714 `"Salisbury-Concord, NC"', add
label define metarea_lbl 716 `"Salt Lake City-Ogden, UT"', add
label define metarea_lbl 720 `"San Angelo, TX"', add
label define metarea_lbl 724 `"San Antonio, TX"', add
label define metarea_lbl 732 `"San Diego, CA"', add
label define metarea_lbl 736 `"San Francisco-Oakland-Vallejo, CA"', add
label define metarea_lbl 740 `"San Jose, CA"', add
label define metarea_lbl 744 `"San Juan-Bayamon, PR"', add
label define metarea_lbl 746 `"San Luis Obispo-Atascad-P Robles, CA"', add
label define metarea_lbl 747 `"Santa Barbara-Santa Maria-Lompoc, CA"', add
label define metarea_lbl 748 `"Santa Cruz, CA"', add
label define metarea_lbl 749 `"Santa Fe, NM"', add
label define metarea_lbl 750 `"Santa Rosa-Petaluma, CA"', add
label define metarea_lbl 751 `"Sarasota, FL"', add
label define metarea_lbl 752 `"Savannah, GA"', add
label define metarea_lbl 756 `"Scranton-Wilkes-Barre, PA"', add
label define metarea_lbl 760 `"Seattle-Everett, WA"', add
label define metarea_lbl 761 `"Sharon, PA"', add
label define metarea_lbl 762 `"Sheboygan, WI"', add
label define metarea_lbl 764 `"Sherman-Davidson, TX"', add
label define metarea_lbl 768 `"Shreveport, LA"', add
label define metarea_lbl 772 `"Sioux City, IA/NE"', add
label define metarea_lbl 776 `"Sioux Falls, SD"', add
label define metarea_lbl 780 `"South Bend-Mishawaka, IN"', add
label define metarea_lbl 784 `"Spokane, WA"', add
label define metarea_lbl 788 `"Springfield, IL"', add
label define metarea_lbl 792 `"Springfield, MO"', add
label define metarea_lbl 800 `"Springfield-Holyoke-Chicopee, MA"', add
label define metarea_lbl 804 `"Stamford, CT"', add
label define metarea_lbl 805 `"State College, PA"', add
label define metarea_lbl 808 `"Steubenville-Weirton,OH/WV"', add
label define metarea_lbl 812 `"Stockton, CA"', add
label define metarea_lbl 814 `"Sumter, SC"', add
label define metarea_lbl 816 `"Syracuse, NY"', add
label define metarea_lbl 820 `"Tacoma, WA"', add
label define metarea_lbl 824 `"Tallahassee, FL"', add
label define metarea_lbl 828 `"Tampa-St. Petersburg-Clearwater, FL"', add
label define metarea_lbl 832 `"Terre Haute, IN"', add
label define metarea_lbl 836 `"Texarkana, TX/AR"', add
label define metarea_lbl 840 `"Toledo, OH/MI"', add
label define metarea_lbl 844 `"Topeka, KS"', add
label define metarea_lbl 848 `"Trenton, NJ"', add
label define metarea_lbl 852 `"Tucson, AZ"', add
label define metarea_lbl 856 `"Tulsa, OK"', add
label define metarea_lbl 860 `"Tuscaloosa, AL"', add
label define metarea_lbl 864 `"Tyler, TX"', add
label define metarea_lbl 868 `"Utica-Rome, NY"', add
label define metarea_lbl 873 `"Ventura-Oxnard-Simi Valley, CA"', add
label define metarea_lbl 875 `"Victoria, TX"', add
label define metarea_lbl 876 `"Vineland-Milville-Bridgetown, NJ"', add
label define metarea_lbl 878 `"Visalia-Tulare-Porterville, CA"', add
label define metarea_lbl 880 `"Waco, TX"', add
label define metarea_lbl 884 `"Washington, DC/MD/VA"', add
label define metarea_lbl 888 `"Waterbury, CT"', add
label define metarea_lbl 892 `"Waterloo-Cedar Falls, IA"', add
label define metarea_lbl 894 `"Wausau, WI"', add
label define metarea_lbl 896 `"West Palm Beach-Boca Raton-Delray Beach, FL"', add
label define metarea_lbl 900 `"Wheeling, WV/OH"', add
label define metarea_lbl 904 `"Wichita, KS"', add
label define metarea_lbl 908 `"Wichita Falls, TX"', add
label define metarea_lbl 914 `"Williamsport, PA"', add
label define metarea_lbl 916 `"Wilmington, DE/NJ/MD"', add
label define metarea_lbl 920 `"Wilmington, NC"', add
label define metarea_lbl 924 `"Worcester, MA"', add
label define metarea_lbl 926 `"Yakima, WA"', add
label define metarea_lbl 927 `"Yolo, CA"', add
label define metarea_lbl 928 `"York, PA"', add
label define metarea_lbl 932 `"Youngstown-Warren, OH/PA"', add
label define metarea_lbl 934 `"Yuba City, CA"', add
label define metarea_lbl 936 `"Yuma, AZ"', add
label values metarea metarea_lbl

label define metaread_lbl 0000 `"Not identifiable or not in an MSA"'
label define metaread_lbl 0040 `"Abilene, TX"', add
label define metaread_lbl 0060 `"Aguadilla, PR"', add
label define metaread_lbl 0080 `"Akron, OH"', add
label define metaread_lbl 0120 `"Albany, GA"', add
label define metaread_lbl 0160 `"Albany-Schenectady-Troy, NY"', add
label define metaread_lbl 0200 `"Albuquerque, NM"', add
label define metaread_lbl 0220 `"Alexandria, LA"', add
label define metaread_lbl 0240 `"Allentown-Bethlehem-Easton, PA/NJ"', add
label define metaread_lbl 0280 `"Altoona, PA"', add
label define metaread_lbl 0320 `"Amarillo, TX"', add
label define metaread_lbl 0380 `"Anchorage, AK"', add
label define metaread_lbl 0400 `"Anderson, IN"', add
label define metaread_lbl 0440 `"Ann Arbor, MI"', add
label define metaread_lbl 0450 `"Anniston, AL"', add
label define metaread_lbl 0460 `"Appleton-Oshkosh-Neenah, WI"', add
label define metaread_lbl 0470 `"Arecibo, PR"', add
label define metaread_lbl 0480 `"Asheville, NC"', add
label define metaread_lbl 0500 `"Athens, GA"', add
label define metaread_lbl 0520 `"Atlanta, GA"', add
label define metaread_lbl 0560 `"Atlantic City, NJ"', add
label define metaread_lbl 0580 `"Auburn-Opelika, AL"', add
label define metaread_lbl 0600 `"Augusta-Aiken, GA/SC"', add
label define metaread_lbl 0640 `"Austin, TX"', add
label define metaread_lbl 0680 `"Bakersfield, CA"', add
label define metaread_lbl 0720 `"Baltimore, MD"', add
label define metaread_lbl 0730 `"Bangor, ME"', add
label define metaread_lbl 0740 `"Barnstable-Yarmouth, MA"', add
label define metaread_lbl 0760 `"Baton Rouge, LA"', add
label define metaread_lbl 0780 `"Battle Creek, MI"', add
label define metaread_lbl 0840 `"Beaumont-Port Arthur-Orange, TX"', add
label define metaread_lbl 0860 `"Bellingham, WA"', add
label define metaread_lbl 0870 `"Benton Harbor, MI"', add
label define metaread_lbl 0880 `"Billings, MT"', add
label define metaread_lbl 0920 `"Biloxi-Gulfport, MS"', add
label define metaread_lbl 0960 `"Binghamton, NY"', add
label define metaread_lbl 1000 `"Birmingham, AL"', add
label define metaread_lbl 1010 `"Bismarck, ND"', add
label define metaread_lbl 1020 `"Bloomington, IN"', add
label define metaread_lbl 1040 `"Bloomington-Normal, IL"', add
label define metaread_lbl 1080 `"Boise City, ID"', add
label define metaread_lbl 1120 `"Boston, MA"', add
label define metaread_lbl 1121 `"Lawrence-Haverhill, MA/NH"', add
label define metaread_lbl 1122 `"Lowell, MA/NH"', add
label define metaread_lbl 1123 `"Salem-Gloucester, MA"', add
label define metaread_lbl 1140 `"Bradenton, FL"', add
label define metaread_lbl 1150 `"Bremerton, WA"', add
label define metaread_lbl 1160 `"Bridgeport, CT"', add
label define metaread_lbl 1200 `"Brockton, MA"', add
label define metaread_lbl 1240 `"Brownsville-Harlingen-San Benito, TX"', add
label define metaread_lbl 1260 `"Bryan-College Station, TX"', add
label define metaread_lbl 1280 `"Buffalo-Niagara Falls, NY"', add
label define metaread_lbl 1281 `"Niagara Falls, NY"', add
label define metaread_lbl 1300 `"Burlington, NC"', add
label define metaread_lbl 1310 `"Burlington, VT"', add
label define metaread_lbl 1320 `"Canton, OH"', add
label define metaread_lbl 1330 `"Caguas, PR"', add
label define metaread_lbl 1350 `"Casper, WY"', add
label define metaread_lbl 1360 `"Cedar Rapids, IA"', add
label define metaread_lbl 1400 `"Champaign-Urbana-Rantoul, IL"', add
label define metaread_lbl 1440 `"Charleston-N. Charleston, SC"', add
label define metaread_lbl 1480 `"Charleston, WV"', add
label define metaread_lbl 1520 `"Charlotte-Gastonia-Rock Hill, SC"', add
label define metaread_lbl 1521 `"Rock Hill, SC"', add
label define metaread_lbl 1540 `"Charlottesville, VA"', add
label define metaread_lbl 1560 `"Chattanooga, TN/GA"', add
label define metaread_lbl 1580 `"Cheyenne, WY"', add
label define metaread_lbl 1600 `"Chicago-Gary-Lake, IL"', add
label define metaread_lbl 1601 `"Aurora-Elgin, IL"', add
label define metaread_lbl 1602 `"Gary-Hammond-East Chicago, IN"', add
label define metaread_lbl 1603 `"Joliet, IL"', add
label define metaread_lbl 1604 `"Lake County, IL"', add
label define metaread_lbl 1620 `"Chico, CA"', add
label define metaread_lbl 1640 `"Cincinnati, OH/KY/IN"', add
label define metaread_lbl 1660 `"Clarksville-Hopkinsville, TN/KY"', add
label define metaread_lbl 1680 `"Cleveland, OH"', add
label define metaread_lbl 1720 `"Colorado Springs, CO"', add
label define metaread_lbl 1740 `"Columbia, MO"', add
label define metaread_lbl 1760 `"Columbia, SC"', add
label define metaread_lbl 1800 `"Columbus, GA/AL"', add
label define metaread_lbl 1840 `"Columbus, OH"', add
label define metaread_lbl 1880 `"Corpus Christi, TX"', add
label define metaread_lbl 1900 `"Cumberland, MD/WV"', add
label define metaread_lbl 1920 `"Dallas-Fort Worth, TX"', add
label define metaread_lbl 1921 `"Fort Worth-Arlington, TX"', add
label define metaread_lbl 1930 `"Danbury, CT"', add
label define metaread_lbl 1950 `"Danville, VA"', add
label define metaread_lbl 1960 `"Davenport, IA - Rock Island-Moline, IL"', add
label define metaread_lbl 2000 `"Dayton-Springfield, OH"', add
label define metaread_lbl 2001 `"Springfield, OH"', add
label define metaread_lbl 2020 `"Daytona Beach, FL"', add
label define metaread_lbl 2030 `"Decatur, AL"', add
label define metaread_lbl 2040 `"Decatur, IL"', add
label define metaread_lbl 2080 `"Denver-Boulder-Longmont, CO"', add
label define metaread_lbl 2081 `"Boulder-Longmont, CO"', add
label define metaread_lbl 2120 `"Des Moines, IA"', add
label define metaread_lbl 2121 `"Polk, IA"', add
label define metaread_lbl 2160 `"Detroit, MI"', add
label define metaread_lbl 2180 `"Dothan, AL"', add
label define metaread_lbl 2190 `"Dover, DE"', add
label define metaread_lbl 2200 `"Dubuque, IA"', add
label define metaread_lbl 2240 `"Duluth-Superior, MN/WI"', add
label define metaread_lbl 2281 `"Dutchess Co., NY"', add
label define metaread_lbl 2290 `"Eau Claire, WI"', add
label define metaread_lbl 2310 `"El Paso, TX"', add
label define metaread_lbl 2320 `"Elkhart-Goshen, IN"', add
label define metaread_lbl 2330 `"Elmira, NY"', add
label define metaread_lbl 2340 `"Enid, OK"', add
label define metaread_lbl 2360 `"Erie, PA"', add
label define metaread_lbl 2400 `"Eugene-Springfield, OR"', add
label define metaread_lbl 2440 `"Evansville, IN/KY"', add
label define metaread_lbl 2520 `"Fargo-Morehead, ND/MN"', add
label define metaread_lbl 2560 `"Fayetteville, NC"', add
label define metaread_lbl 2580 `"Fayetteville-Springdale, AR"', add
label define metaread_lbl 2600 `"Fitchburg-Leominster, MA"', add
label define metaread_lbl 2620 `"Flagstaff, AZ/UT"', add
label define metaread_lbl 2640 `"Flint, MI"', add
label define metaread_lbl 2650 `"Florence, AL"', add
label define metaread_lbl 2660 `"Florence, SC"', add
label define metaread_lbl 2670 `"Fort Collins-Loveland, CO"', add
label define metaread_lbl 2680 `"Fort Lauderdale-Hollywood-Pompano Beach, FL"', add
label define metaread_lbl 2700 `"Fort Myers-Cape Coral, FL"', add
label define metaread_lbl 2710 `"Fort Pierce, FL"', add
label define metaread_lbl 2720 `"Fort Smith, AR/OK"', add
label define metaread_lbl 2750 `"Fort Walton Beach, FL"', add
label define metaread_lbl 2760 `"Fort Wayne, IN"', add
label define metaread_lbl 2840 `"Fresno, CA"', add
label define metaread_lbl 2880 `"Gadsden, AL"', add
label define metaread_lbl 2900 `"Gainesville, FL"', add
label define metaread_lbl 2920 `"Galveston-Texas City, TX"', add
label define metaread_lbl 2970 `"Glens Falls, NY"', add
label define metaread_lbl 2980 `"Goldsboro, NC"', add
label define metaread_lbl 2990 `"Grand Forks, ND/MN"', add
label define metaread_lbl 3000 `"Grand Rapids, MI"', add
label define metaread_lbl 3010 `"Grand Junction, CO"', add
label define metaread_lbl 3040 `"Great Falls, MT"', add
label define metaread_lbl 3060 `"Greeley, CO"', add
label define metaread_lbl 3080 `"Green Bay, WI"', add
label define metaread_lbl 3120 `"Greensboro-Winston Salem-High Point, NC"', add
label define metaread_lbl 3121 `"Winston-Salem, NC"', add
label define metaread_lbl 3150 `"Greenville, NC"', add
label define metaread_lbl 3160 `"Greenville-Spartenburg-Anderson, SC"', add
label define metaread_lbl 3161 `"Anderson, SC"', add
label define metaread_lbl 3180 `"Hagerstown, MD"', add
label define metaread_lbl 3200 `"Hamilton-Middleton, OH"', add
label define metaread_lbl 3240 `"Harrisburg-Lebanon-Carlisle, PA"', add
label define metaread_lbl 3280 `"Hartford-Bristol-Middleton-New Britain, CT"', add
label define metaread_lbl 3281 `"Bristol, CT"', add
label define metaread_lbl 3282 `"Middletown, CT"', add
label define metaread_lbl 3283 `"New Britain, CT"', add
label define metaread_lbl 3290 `"Hickory-Morganton, NC"', add
label define metaread_lbl 3300 `"Hattiesburg, MS"', add
label define metaread_lbl 3320 `"Honolulu, HI"', add
label define metaread_lbl 3350 `"Houma-Thibodoux, LA"', add
label define metaread_lbl 3360 `"Houston-Brazoria, TX"', add
label define metaread_lbl 3361 `"Brazoria, TX"', add
label define metaread_lbl 3400 `"Huntington-Ashland, WV/KY/OH"', add
label define metaread_lbl 3440 `"Huntsville, AL"', add
label define metaread_lbl 3480 `"Indianapolis, IN"', add
label define metaread_lbl 3500 `"Iowa City, IA"', add
label define metaread_lbl 3520 `"Jackson, MI"', add
label define metaread_lbl 3560 `"Jackson, MS"', add
label define metaread_lbl 3580 `"Jackson, TN"', add
label define metaread_lbl 3590 `"Jacksonville, FL"', add
label define metaread_lbl 3600 `"Jacksonville, NC"', add
label define metaread_lbl 3610 `"Jamestown-Dunkirk, NY"', add
label define metaread_lbl 3620 `"Janesville-Beloit, WI"', add
label define metaread_lbl 3660 `"Johnson City-Kingsport-Bristol, TN/VA"', add
label define metaread_lbl 3680 `"Johnstown, PA"', add
label define metaread_lbl 3710 `"Joplin, MO"', add
label define metaread_lbl 3720 `"Kalamazoo-Portage, MI"', add
label define metaread_lbl 3740 `"Kankakee, IL"', add
label define metaread_lbl 3760 `"Kansas City, MO/KS"', add
label define metaread_lbl 3800 `"Kenosha, WI"', add
label define metaread_lbl 3810 `"Kileen-Temple, TX"', add
label define metaread_lbl 3840 `"Knoxville, TN"', add
label define metaread_lbl 3850 `"Kokomo, IN"', add
label define metaread_lbl 3870 `"LaCrosse, WI"', add
label define metaread_lbl 3880 `"Lafayette, LA"', add
label define metaread_lbl 3920 `"Lafayette-W. Lafayette, IN"', add
label define metaread_lbl 3960 `"Lake Charles, LA"', add
label define metaread_lbl 3980 `"Lakeland-Winterhaven, FL"', add
label define metaread_lbl 4000 `"Lancaster, PA"', add
label define metaread_lbl 4040 `"Lansing-E. Lansing, MI"', add
label define metaread_lbl 4080 `"Laredo, TX"', add
label define metaread_lbl 4100 `"Las Cruces, NM"', add
label define metaread_lbl 4120 `"Las Vegas, NV"', add
label define metaread_lbl 4150 `"Lawrence, KS"', add
label define metaread_lbl 4200 `"Lawton, OK"', add
label define metaread_lbl 4240 `"Lewiston-Auburn, ME"', add
label define metaread_lbl 4280 `"Lexington-Fayette, KY"', add
label define metaread_lbl 4320 `"Lima, OH"', add
label define metaread_lbl 4360 `"Lincoln, NE"', add
label define metaread_lbl 4400 `"Little Rock-N. Little Rock, AR"', add
label define metaread_lbl 4410 `"Long Branch-Asbury Park, NJ"', add
label define metaread_lbl 4420 `"Longview-Marshall, TX"', add
label define metaread_lbl 4440 `"Lorain-Elyria, OH"', add
label define metaread_lbl 4480 `"Los Angeles-Long Beach, CA"', add
label define metaread_lbl 4481 `"Anaheim-Santa Ana-Garden Grove, CA"', add
label define metaread_lbl 4482 `"Orange County, CA"', add
label define metaread_lbl 4520 `"Louisville, KY/IN"', add
label define metaread_lbl 4600 `"Lubbock, TX"', add
label define metaread_lbl 4640 `"Lynchburg, VA"', add
label define metaread_lbl 4680 `"Macon-Warner Robins, GA"', add
label define metaread_lbl 4720 `"Madison, WI"', add
label define metaread_lbl 4760 `"Manchester, NH"', add
label define metaread_lbl 4800 `"Mansfield, OH"', add
label define metaread_lbl 4840 `"Mayaguez, PR"', add
label define metaread_lbl 4880 `"McAllen-Edinburg-Pharr-Mission, TX"', add
label define metaread_lbl 4890 `"Medford, OR"', add
label define metaread_lbl 4900 `"Melbourne-Titusville-Cocoa-Palm Bay, FL"', add
label define metaread_lbl 4920 `"Memphis, TN/AR/MS"', add
label define metaread_lbl 4940 `"Merced, CA"', add
label define metaread_lbl 5000 `"Miami-Hialeah, FL"', add
label define metaread_lbl 5040 `"Midland, TX"', add
label define metaread_lbl 5080 `"Milwaukee, WI"', add
label define metaread_lbl 5120 `"Minneapolis-St. Paul, MN"', add
label define metaread_lbl 5140 `"Missoula, MT"', add
label define metaread_lbl 5160 `"Mobile, AL"', add
label define metaread_lbl 5170 `"Modesto, CA"', add
label define metaread_lbl 5190 `"Monmouth-Ocean, NJ"', add
label define metaread_lbl 5200 `"Monroe, LA"', add
label define metaread_lbl 5240 `"Montgomery, AL"', add
label define metaread_lbl 5280 `"Muncie, IN"', add
label define metaread_lbl 5320 `"Muskegon-Norton Shores-Muskegon Heights, MI"', add
label define metaread_lbl 5330 `"Myrtle Beach, SC"', add
label define metaread_lbl 5340 `"Naples, FL"', add
label define metaread_lbl 5350 `"Nashua, NH"', add
label define metaread_lbl 5360 `"Nashville, TN"', add
label define metaread_lbl 5400 `"New Bedford, MA"', add
label define metaread_lbl 5460 `"New Brunswick-Perth Amboy-Sayreville, NJ"', add
label define metaread_lbl 5480 `"New Haven-Meriden, CT"', add
label define metaread_lbl 5481 `"Meriden"', add
label define metaread_lbl 5482 `"New Haven, CT"', add
label define metaread_lbl 5520 `"New London-Norwich, CT/RI"', add
label define metaread_lbl 5560 `"New Orleans, LA"', add
label define metaread_lbl 5600 `"New York, NY-Northeastern NJ"', add
label define metaread_lbl 5601 `"Nassau Co, NY"', add
label define metaread_lbl 5602 `"Bergen-Passaic, NJ"', add
label define metaread_lbl 5603 `"Jersey City, NJ"', add
label define metaread_lbl 5604 `"Middlesex-Somerset-Hunterdon, NJ"', add
label define metaread_lbl 5605 `"Newark, NJ"', add
label define metaread_lbl 5640 `"Newark, OH"', add
label define metaread_lbl 5660 `"Newburgh-Middletown, NY"', add
label define metaread_lbl 5720 `"Norfolk-VA Beach-Newport News, VA"', add
label define metaread_lbl 5721 `"Newport News-Hampton"', add
label define metaread_lbl 5722 `"Norfolk- VA Beach-Portsmouth"', add
label define metaread_lbl 5760 `"Norwalk, CT"', add
label define metaread_lbl 5790 `"Ocala, FL"', add
label define metaread_lbl 5800 `"Odessa, TX"', add
label define metaread_lbl 5880 `"Oklahoma City, OK"', add
label define metaread_lbl 5910 `"Olympia, WA"', add
label define metaread_lbl 5920 `"Omaha, NE/IA"', add
label define metaread_lbl 5950 `"Orange, NY"', add
label define metaread_lbl 5960 `"Orlando, FL"', add
label define metaread_lbl 5990 `"Owensboro, KY"', add
label define metaread_lbl 6010 `"Panama City, FL"', add
label define metaread_lbl 6020 `"Parkersburg-Marietta,WV/OH"', add
label define metaread_lbl 6030 `"Pascagoula-Moss Point, MS"', add
label define metaread_lbl 6080 `"Pensacola, FL"', add
label define metaread_lbl 6120 `"Peoria, IL"', add
label define metaread_lbl 6160 `"Philadelphia, PA/NJ"', add
label define metaread_lbl 6200 `"Phoenix, AZ"', add
label define metaread_lbl 6240 `"Pine Bluff, AR"', add
label define metaread_lbl 6280 `"Pittsburgh-Beaver Valley, PA"', add
label define metaread_lbl 6281 `"Beaver County, PA"', add
label define metaread_lbl 6320 `"Pittsfield, MA"', add
label define metaread_lbl 6360 `"Ponce, PR"', add
label define metaread_lbl 6400 `"Portland, ME"', add
label define metaread_lbl 6440 `"Portland-Vancouver, OR"', add
label define metaread_lbl 6441 `"Vancouver, WA"', add
label define metaread_lbl 6450 `"Portsmouth-Dover-Rochester, NH/ME"', add
label define metaread_lbl 6460 `"Poughkeepsie, NY"', add
label define metaread_lbl 6480 `"Providence-Fall River-Pawtucket, MA/RI"', add
label define metaread_lbl 6481 `"Fall River, MA/RI"', add
label define metaread_lbl 6482 `"Pawtuckett-Woonsocket-Attleboro, RI/MA"', add
label define metaread_lbl 6520 `"Provo-Orem, UT"', add
label define metaread_lbl 6560 `"Pueblo, CO"', add
label define metaread_lbl 6580 `"Punta Gorda, FL"', add
label define metaread_lbl 6600 `"Racine, WI"', add
label define metaread_lbl 6640 `"Raleigh-Durham, NC"', add
label define metaread_lbl 6641 `"Durham, NC"', add
label define metaread_lbl 6660 `"Rapid City, SD"', add
label define metaread_lbl 6680 `"Reading, PA"', add
label define metaread_lbl 6690 `"Redding, CA"', add
label define metaread_lbl 6720 `"Reno, NV"', add
label define metaread_lbl 6740 `"Richland-Kennewick-Pasco, WA"', add
label define metaread_lbl 6760 `"Richmond-Petersburg, VA"', add
label define metaread_lbl 6761 `"Petersburg-Colonial Heights, VA"', add
label define metaread_lbl 6780 `"Riverside-San Bernardino, CA"', add
label define metaread_lbl 6781 `"San Bernardino, CA"', add
label define metaread_lbl 6800 `"Roanoke, VA"', add
label define metaread_lbl 6820 `"Rochester, MN"', add
label define metaread_lbl 6840 `"Rochester, NY"', add
label define metaread_lbl 6880 `"Rockford, IL"', add
label define metaread_lbl 6895 `"Rocky Mount, NC"', add
label define metaread_lbl 6920 `"Sacramento, CA"', add
label define metaread_lbl 6960 `"Saginaw-Bay City-Midland, MI"', add
label define metaread_lbl 6961 `"Bay City, MI"', add
label define metaread_lbl 6980 `"St. Cloud, MN"', add
label define metaread_lbl 7000 `"St. Joseph, MO"', add
label define metaread_lbl 7040 `"St. Louis, MO/IL"', add
label define metaread_lbl 7080 `"Salem, OR"', add
label define metaread_lbl 7120 `"Salinas-Sea Side-Monterey, CA"', add
label define metaread_lbl 7140 `"Salisbury-Concord, NC"', add
label define metaread_lbl 7160 `"Salt Lake City-Ogden, UT"', add
label define metaread_lbl 7161 `"Ogden"', add
label define metaread_lbl 7200 `"San Angelo, TX"', add
label define metaread_lbl 7240 `"San Antonio, TX"', add
label define metaread_lbl 7320 `"San Diego, CA"', add
label define metaread_lbl 7360 `"San Francisco-Oakland-Vallejo, CA"', add
label define metaread_lbl 7361 `"Oakland, CA"', add
label define metaread_lbl 7362 `"Vallejo-Fairfield-Napa, CA"', add
label define metaread_lbl 7400 `"San Jose, CA"', add
label define metaread_lbl 7440 `"San Juan-Bayamon, PR"', add
label define metaread_lbl 7460 `"San Luis Obispo-Atascad-P Robles, CA"', add
label define metaread_lbl 7470 `"Santa Barbara-Santa Maria-Lompoc, CA"', add
label define metaread_lbl 7480 `"Santa Cruz, CA"', add
label define metaread_lbl 7490 `"Santa Fe, NM"', add
label define metaread_lbl 7500 `"Santa Rosa-Petaluma, CA"', add
label define metaread_lbl 7510 `"Sarasota, FL"', add
label define metaread_lbl 7520 `"Savannah, GA"', add
label define metaread_lbl 7560 `"Scranton-Wilkes-Barre, PA"', add
label define metaread_lbl 7561 `"Wilkes-Barre-Hazelton, PA"', add
label define metaread_lbl 7600 `"Seattle-Everett, WA"', add
label define metaread_lbl 7610 `"Sharon, PA"', add
label define metaread_lbl 7620 `"Sheboygan, WI"', add
label define metaread_lbl 7640 `"Sherman-Denison, TX"', add
label define metaread_lbl 7680 `"Shreveport, LA"', add
label define metaread_lbl 7720 `"Sioux City, IA/NE"', add
label define metaread_lbl 7760 `"Sioux Falls, SD"', add
label define metaread_lbl 7800 `"South Bend-Mishawaka, IN"', add
label define metaread_lbl 7840 `"Spokane, WA"', add
label define metaread_lbl 7880 `"Springfield, IL"', add
label define metaread_lbl 7920 `"Springfield, MO"', add
label define metaread_lbl 8000 `"Springfield-Holyoke-Chicopee, MA"', add
label define metaread_lbl 8040 `"Stamford, CT"', add
label define metaread_lbl 8050 `"State College, PA"', add
label define metaread_lbl 8080 `"Steubenville-Weirton,OH/WV"', add
label define metaread_lbl 8120 `"Stockton, CA"', add
label define metaread_lbl 8140 `"Sumter, SC"', add
label define metaread_lbl 8160 `"Syracuse, NY"', add
label define metaread_lbl 8200 `"Tacoma, WA"', add
label define metaread_lbl 8240 `"Tallahassee, FL"', add
label define metaread_lbl 8280 `"Tampa-St. Petersburg-Clearwater, FL"', add
label define metaread_lbl 8320 `"Terre Haute, IN"', add
label define metaread_lbl 8360 `"Texarkana, TX/AR"', add
label define metaread_lbl 8400 `"Toledo, OH/MI"', add
label define metaread_lbl 8440 `"Topeka, KS"', add
label define metaread_lbl 8480 `"Trenton, NJ"', add
label define metaread_lbl 8520 `"Tucson, AZ"', add
label define metaread_lbl 8560 `"Tulsa, OK"', add
label define metaread_lbl 8600 `"Tuscaloosa, AL"', add
label define metaread_lbl 8640 `"Tyler, TX"', add
label define metaread_lbl 8680 `"Utica-Rome, NY"', add
label define metaread_lbl 8730 `"Ventura-Oxnard-Simi Valley, CA"', add
label define metaread_lbl 8750 `"Victoria, TX"', add
label define metaread_lbl 8760 `"Vineland-Milville-Bridgetown, NJ"', add
label define metaread_lbl 8780 `"Visalia-Tulare-Porterville, CA"', add
label define metaread_lbl 8800 `"Waco, TX"', add
label define metaread_lbl 8840 `"Washington, DC/MD/VA"', add
label define metaread_lbl 8880 `"Waterbury, CT"', add
label define metaread_lbl 8920 `"Waterloo-Cedar Falls, IA"', add
label define metaread_lbl 8940 `"Wausau, WI"', add
label define metaread_lbl 8960 `"West Palm Beach-Boca Raton-Delray Beach, FL"', add
label define metaread_lbl 9000 `"Wheeling, WV/OH"', add
label define metaread_lbl 9040 `"Wichita, KS"', add
label define metaread_lbl 9080 `"Wichita Falls, TX"', add
label define metaread_lbl 9140 `"Williamsport, PA"', add
label define metaread_lbl 9160 `"Wilmington, DE/NJ/MD"', add
label define metaread_lbl 9200 `"Wilmington, NC"', add
label define metaread_lbl 9240 `"Worcester, MA"', add
label define metaread_lbl 9260 `"Yakima, WA"', add
label define metaread_lbl 9270 `"Yolo, CA"', add
label define metaread_lbl 9280 `"York, PA"', add
label define metaread_lbl 9320 `"Youngstown-Warren, OH/PA"', add
label define metaread_lbl 9340 `"Yuba City, CA"', add
label define metaread_lbl 9360 `"Yuma, AZ"', add
label values metaread metaread_lbl

label define gq_lbl 0 `"Vacant unit"'
label define gq_lbl 1 `"Households under 1970 definition"', add
label define gq_lbl 2 `"Additional households under 1990 definition"', add
label define gq_lbl 3 `"Group quarters--Institutions"', add
label define gq_lbl 4 `"Other group quarters"', add
label define gq_lbl 5 `"Additional households under 2000 definition"', add
label define gq_lbl 6 `"Fragment"', add
label values gq gq_lbl

label define sex_lbl 1 `"Male"'
label define sex_lbl 2 `"Female"', add
label values sex sex_lbl

label define age_lbl 000 `"Less than 1 year old"'
label define age_lbl 001 `"1"', add
label define age_lbl 002 `"2"', add
label define age_lbl 003 `"3"', add
label define age_lbl 004 `"4"', add
label define age_lbl 005 `"5"', add
label define age_lbl 006 `"6"', add
label define age_lbl 007 `"7"', add
label define age_lbl 008 `"8"', add
label define age_lbl 009 `"9"', add
label define age_lbl 010 `"10"', add
label define age_lbl 011 `"11"', add
label define age_lbl 012 `"12"', add
label define age_lbl 013 `"13"', add
label define age_lbl 014 `"14"', add
label define age_lbl 015 `"15"', add
label define age_lbl 016 `"16"', add
label define age_lbl 017 `"17"', add
label define age_lbl 018 `"18"', add
label define age_lbl 019 `"19"', add
label define age_lbl 020 `"20"', add
label define age_lbl 021 `"21"', add
label define age_lbl 022 `"22"', add
label define age_lbl 023 `"23"', add
label define age_lbl 024 `"24"', add
label define age_lbl 025 `"25"', add
label define age_lbl 026 `"26"', add
label define age_lbl 027 `"27"', add
label define age_lbl 028 `"28"', add
label define age_lbl 029 `"29"', add
label define age_lbl 030 `"30"', add
label define age_lbl 031 `"31"', add
label define age_lbl 032 `"32"', add
label define age_lbl 033 `"33"', add
label define age_lbl 034 `"34"', add
label define age_lbl 035 `"35"', add
label define age_lbl 036 `"36"', add
label define age_lbl 037 `"37"', add
label define age_lbl 038 `"38"', add
label define age_lbl 039 `"39"', add
label define age_lbl 040 `"40"', add
label define age_lbl 041 `"41"', add
label define age_lbl 042 `"42"', add
label define age_lbl 043 `"43"', add
label define age_lbl 044 `"44"', add
label define age_lbl 045 `"45"', add
label define age_lbl 046 `"46"', add
label define age_lbl 047 `"47"', add
label define age_lbl 048 `"48"', add
label define age_lbl 049 `"49"', add
label define age_lbl 050 `"50"', add
label define age_lbl 051 `"51"', add
label define age_lbl 052 `"52"', add
label define age_lbl 053 `"53"', add
label define age_lbl 054 `"54"', add
label define age_lbl 055 `"55"', add
label define age_lbl 056 `"56"', add
label define age_lbl 057 `"57"', add
label define age_lbl 058 `"58"', add
label define age_lbl 059 `"59"', add
label define age_lbl 060 `"60"', add
label define age_lbl 061 `"61"', add
label define age_lbl 062 `"62"', add
label define age_lbl 063 `"63"', add
label define age_lbl 064 `"64"', add
label define age_lbl 065 `"65"', add
label define age_lbl 066 `"66"', add
label define age_lbl 067 `"67"', add
label define age_lbl 068 `"68"', add
label define age_lbl 069 `"69"', add
label define age_lbl 070 `"70"', add
label define age_lbl 071 `"71"', add
label define age_lbl 072 `"72"', add
label define age_lbl 073 `"73"', add
label define age_lbl 074 `"74"', add
label define age_lbl 075 `"75"', add
label define age_lbl 076 `"76"', add
label define age_lbl 077 `"77"', add
label define age_lbl 078 `"78"', add
label define age_lbl 079 `"79"', add
label define age_lbl 080 `"80"', add
label define age_lbl 081 `"81"', add
label define age_lbl 082 `"82"', add
label define age_lbl 083 `"83"', add
label define age_lbl 084 `"84"', add
label define age_lbl 085 `"85"', add
label define age_lbl 086 `"86"', add
label define age_lbl 087 `"87"', add
label define age_lbl 088 `"88"', add
label define age_lbl 089 `"89"', add
label define age_lbl 090 `"90 (90+ in 1980 and 1990)"', add
label define age_lbl 091 `"91"', add
label define age_lbl 092 `"92"', add
label define age_lbl 093 `"93"', add
label define age_lbl 094 `"94"', add
label define age_lbl 095 `"95"', add
label define age_lbl 096 `"96"', add
label define age_lbl 097 `"97"', add
label define age_lbl 098 `"98"', add
label define age_lbl 099 `"99"', add
label define age_lbl 100 `"100 (100+ in 1960-1970)"', add
label define age_lbl 101 `"101"', add
label define age_lbl 102 `"102"', add
label define age_lbl 103 `"103"', add
label define age_lbl 104 `"104"', add
label define age_lbl 105 `"105"', add
label define age_lbl 106 `"106"', add
label define age_lbl 107 `"107"', add
label define age_lbl 108 `"108"', add
label define age_lbl 109 `"109"', add
label define age_lbl 110 `"110"', add
label define age_lbl 111 `"111"', add
label define age_lbl 112 `"112 (112+ in the 1980 internal data)"', add
label define age_lbl 113 `"113"', add
label define age_lbl 114 `"114"', add
label define age_lbl 115 `"115 (115+ in the 1990 internal data)"', add
label define age_lbl 116 `"116"', add
label define age_lbl 117 `"117"', add
label define age_lbl 118 `"118"', add
label define age_lbl 119 `"119"', add
label define age_lbl 120 `"120"', add
label define age_lbl 121 `"121"', add
label define age_lbl 122 `"122"', add
label define age_lbl 123 `"123"', add
label define age_lbl 124 `"124"', add
label define age_lbl 125 `"125"', add
label define age_lbl 126 `"126"', add
label define age_lbl 129 `"129"', add
label define age_lbl 130 `"130"', add
label define age_lbl 135 `"135"', add
label values age age_lbl

label define race_lbl 1 `"White"'
label define race_lbl 2 `"Black/African American/Negro"', add
label define race_lbl 3 `"American Indian or Alaska Native"', add
label define race_lbl 4 `"Chinese"', add
label define race_lbl 5 `"Japanese"', add
label define race_lbl 6 `"Other Asian or Pacific Islander"', add
label define race_lbl 7 `"Other race, nec"', add
label define race_lbl 8 `"Two major races"', add
label define race_lbl 9 `"Three or more major races"', add
label values race race_lbl

label define raced_lbl 100 `"White"'
label define raced_lbl 110 `"Spanish write_in"', add
label define raced_lbl 120 `"Blank (white) (1850)"', add
label define raced_lbl 130 `"Portuguese"', add
label define raced_lbl 140 `"Mexican (1930)"', add
label define raced_lbl 150 `"Puerto Rican (1910 Hawaii)"', add
label define raced_lbl 200 `"Black/African American/Negro"', add
label define raced_lbl 210 `"Mulatto"', add
label define raced_lbl 300 `"American Indian/Alaska Native"', add
label define raced_lbl 302 `"Apache"', add
label define raced_lbl 303 `"Blackfoot"', add
label define raced_lbl 304 `"Cherokee"', add
label define raced_lbl 305 `"Cheyenne"', add
label define raced_lbl 306 `"Chickasaw"', add
label define raced_lbl 307 `"Chippewa"', add
label define raced_lbl 308 `"Choctaw"', add
label define raced_lbl 309 `"Comanche"', add
label define raced_lbl 310 `"Creek"', add
label define raced_lbl 311 `"Crow"', add
label define raced_lbl 312 `"Iroquois"', add
label define raced_lbl 313 `"Kiowa"', add
label define raced_lbl 314 `"Lumbee"', add
label define raced_lbl 315 `"Navajo"', add
label define raced_lbl 316 `"Osage"', add
label define raced_lbl 317 `"Paiute"', add
label define raced_lbl 318 `"Pima"', add
label define raced_lbl 319 `"Potawatomi"', add
label define raced_lbl 320 `"Pueblo"', add
label define raced_lbl 321 `"Seminole"', add
label define raced_lbl 322 `"Shoshone"', add
label define raced_lbl 323 `"Sioux"', add
label define raced_lbl 324 `"Tlingit (Tlingit_Haida, 2000/ACS)"', add
label define raced_lbl 325 `"Tohono O Odham"', add
label define raced_lbl 326 `"All other tribes (1990)"', add
label define raced_lbl 328 `"Hopi"', add
label define raced_lbl 329 `"Central American Indian"', add
label define raced_lbl 330 `"Spanish American Indian"', add
label define raced_lbl 350 `"Delaware"', add
label define raced_lbl 351 `"Latin American Indian"', add
label define raced_lbl 352 `"Puget Sound Salish"', add
label define raced_lbl 353 `"Yakama"', add
label define raced_lbl 354 `"Yaqui"', add
label define raced_lbl 355 `"Colville"', add
label define raced_lbl 356 `"Houma"', add
label define raced_lbl 357 `"Menominee"', add
label define raced_lbl 358 `"Yuman"', add
label define raced_lbl 359 `"South American Indian"', add
label define raced_lbl 360 `"Mexican American Indian"', add
label define raced_lbl 361 `"Other Amer. Indian tribe (2000,ACS)"', add
label define raced_lbl 362 `"2+ Amer. Indian tribes (2000,ACS)"', add
label define raced_lbl 370 `"Alaskan Athabaskan"', add
label define raced_lbl 371 `"Aleut"', add
label define raced_lbl 372 `"Eskimo"', add
label define raced_lbl 373 `"Alaskan mixed"', add
label define raced_lbl 374 `"Inupiat"', add
label define raced_lbl 375 `"Yup'ik"', add
label define raced_lbl 379 `"Other Alaska Native tribe(s) (2000,ACS)"', add
label define raced_lbl 398 `"Both Am. Ind. and Alaska Native (2000,ACS)"', add
label define raced_lbl 399 `"Tribe not specified"', add
label define raced_lbl 400 `"Chinese"', add
label define raced_lbl 410 `"Taiwanese"', add
label define raced_lbl 420 `"Chinese and Taiwanese"', add
label define raced_lbl 500 `"Japanese"', add
label define raced_lbl 600 `"Filipino"', add
label define raced_lbl 610 `"Asian Indian (Hindu 1920_1940)"', add
label define raced_lbl 620 `"Korean"', add
label define raced_lbl 630 `"Hawaiian"', add
label define raced_lbl 631 `"Hawaiian and Asian (1900,1920)"', add
label define raced_lbl 632 `"Hawaiian and European (1900,1920)"', add
label define raced_lbl 634 `"Hawaiian mixed"', add
label define raced_lbl 640 `"Vietnamese"', add
label define raced_lbl 641 `"Bhutanese"', add
label define raced_lbl 642 `"Mongolian"', add
label define raced_lbl 643 `"Nepalese"', add
label define raced_lbl 650 `"Other Asian or Pacific Islander (1920,1980)"', add
label define raced_lbl 651 `"Asian only (CPS)"', add
label define raced_lbl 652 `"Pacific Islander only (CPS)"', add
label define raced_lbl 653 `"Asian or Pacific Islander, n.s. (1990 Internal Census files)"', add
label define raced_lbl 660 `"Cambodian"', add
label define raced_lbl 661 `"Hmong"', add
label define raced_lbl 662 `"Laotian"', add
label define raced_lbl 663 `"Thai"', add
label define raced_lbl 664 `"Bangladeshi"', add
label define raced_lbl 665 `"Burmese"', add
label define raced_lbl 666 `"Indonesian"', add
label define raced_lbl 667 `"Malaysian"', add
label define raced_lbl 668 `"Okinawan"', add
label define raced_lbl 669 `"Pakistani"', add
label define raced_lbl 670 `"Sri Lankan"', add
label define raced_lbl 671 `"Other Asian, n.e.c."', add
label define raced_lbl 672 `"Asian, not specified"', add
label define raced_lbl 673 `"Chinese and Japanese"', add
label define raced_lbl 674 `"Chinese and Filipino"', add
label define raced_lbl 675 `"Chinese and Vietnamese"', add
label define raced_lbl 676 `"Chinese and Asian write_in"', add
label define raced_lbl 677 `"Japanese and Filipino"', add
label define raced_lbl 678 `"Asian Indian and Asian write_in"', add
label define raced_lbl 679 `"Other Asian race combinations"', add
label define raced_lbl 680 `"Samoan"', add
label define raced_lbl 681 `"Tahitian"', add
label define raced_lbl 682 `"Tongan"', add
label define raced_lbl 683 `"Other Polynesian (1990)"', add
label define raced_lbl 684 `"1+ other Polynesian races (2000,ACS)"', add
label define raced_lbl 685 `"Guamanian/Chamorro"', add
label define raced_lbl 686 `"Northern Mariana Islander"', add
label define raced_lbl 687 `"Palauan"', add
label define raced_lbl 688 `"Other Micronesian (1990)"', add
label define raced_lbl 689 `"1+ other Micronesian races (2000,ACS)"', add
label define raced_lbl 690 `"Fijian"', add
label define raced_lbl 691 `"Other Melanesian (1990)"', add
label define raced_lbl 692 `"1+ other Melanesian races (2000,ACS)"', add
label define raced_lbl 698 `"2+ PI races from 2+ PI regions"', add
label define raced_lbl 699 `"Pacific Islander, n.s."', add
label define raced_lbl 700 `"Other race, n.e.c."', add
label define raced_lbl 801 `"White and Black"', add
label define raced_lbl 802 `"White and AIAN"', add
label define raced_lbl 810 `"White and Asian"', add
label define raced_lbl 811 `"White and Chinese"', add
label define raced_lbl 812 `"White and Japanese"', add
label define raced_lbl 813 `"White and Filipino"', add
label define raced_lbl 814 `"White and Asian Indian"', add
label define raced_lbl 815 `"White and Korean"', add
label define raced_lbl 816 `"White and Vietnamese"', add
label define raced_lbl 817 `"White and Asian write_in"', add
label define raced_lbl 818 `"White and other Asian race(s)"', add
label define raced_lbl 819 `"White and two or more Asian groups"', add
label define raced_lbl 820 `"White and PI"', add
label define raced_lbl 821 `"White and Native Hawaiian"', add
label define raced_lbl 822 `"White and Samoan"', add
label define raced_lbl 823 `"White and Guamanian"', add
label define raced_lbl 824 `"White and PI write_in"', add
label define raced_lbl 825 `"White and other PI race(s)"', add
label define raced_lbl 826 `"White and other race write_in"', add
label define raced_lbl 827 `"White and other race, n.e.c."', add
label define raced_lbl 830 `"Black and AIAN"', add
label define raced_lbl 831 `"Black and Asian"', add
label define raced_lbl 832 `"Black and Chinese"', add
label define raced_lbl 833 `"Black and Japanese"', add
label define raced_lbl 834 `"Black and Filipino"', add
label define raced_lbl 835 `"Black and Asian Indian"', add
label define raced_lbl 836 `"Black and Korean"', add
label define raced_lbl 837 `"Black and Asian write_in"', add
label define raced_lbl 838 `"Black and other Asian race(s)"', add
label define raced_lbl 840 `"Black and PI"', add
label define raced_lbl 841 `"Black and PI write_in"', add
label define raced_lbl 842 `"Black and other PI race(s)"', add
label define raced_lbl 845 `"Black and other race write_in"', add
label define raced_lbl 850 `"AIAN and Asian"', add
label define raced_lbl 851 `"AIAN and Filipino (2000 1%)"', add
label define raced_lbl 852 `"AIAN and Asian Indian"', add
label define raced_lbl 853 `"AIAN and Asian write_in (2000 1%)"', add
label define raced_lbl 854 `"AIAN and other Asian race(s)"', add
label define raced_lbl 855 `"AIAN and PI"', add
label define raced_lbl 856 `"AIAN and other race write_in"', add
label define raced_lbl 860 `"Asian and PI"', add
label define raced_lbl 861 `"Chinese and Hawaiian"', add
label define raced_lbl 862 `"Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 863 `"Japanese and Hawaiian (2000 1%)"', add
label define raced_lbl 864 `"Filipino and Hawaiian"', add
label define raced_lbl 865 `"Filipino and PI write_in"', add
label define raced_lbl 866 `"Asian Indian and PI write_in (2000 1%)"', add
label define raced_lbl 867 `"Asian write_in and PI write_in"', add
label define raced_lbl 868 `"Other Asian race(s) and PI race(s)"', add
label define raced_lbl 869 `"Japanese and Korean (ACS)"', add
label define raced_lbl 880 `"Asian and other race write_in"', add
label define raced_lbl 881 `"Chinese and other race write_in"', add
label define raced_lbl 882 `"Japanese and other race write_in"', add
label define raced_lbl 883 `"Filipino and other race write_in"', add
label define raced_lbl 884 `"Asian Indian and other race write_in"', add
label define raced_lbl 885 `"Asian write_in and other race write_in"', add
label define raced_lbl 886 `"Other Asian race(s) and other race write_in"', add
label define raced_lbl 887 `"Chinese and Korean"', add
label define raced_lbl 890 `"PI and other race write_in:"', add
label define raced_lbl 891 `"PI write_in and other race write_in"', add
label define raced_lbl 892 `"Other PI race(s) and other race write_in"', add
label define raced_lbl 893 `"Native Hawaiian or PI other race(s)"', add
label define raced_lbl 899 `"API and other race write_in"', add
label define raced_lbl 901 `"White, Black, AIAN"', add
label define raced_lbl 902 `"White, Black, Asian"', add
label define raced_lbl 903 `"White, Black, PI"', add
label define raced_lbl 904 `"White, Black, other race write_in"', add
label define raced_lbl 905 `"White, AIAN, Asian"', add
label define raced_lbl 906 `"White, AIAN, PI"', add
label define raced_lbl 907 `"White, AIAN, other race write_in"', add
label define raced_lbl 910 `"White, Asian, PI"', add
label define raced_lbl 911 `"White, Chinese, Hawaiian"', add
label define raced_lbl 912 `"White, Chinese, Filipino, Hawaiian (2000 1%)"', add
label define raced_lbl 913 `"White, Japanese, Hawaiian (2000 1%)"', add
label define raced_lbl 914 `"White, Filipino, Hawaiian"', add
label define raced_lbl 915 `"Other White, Asian race(s), PI race(s)"', add
label define raced_lbl 916 `"White, AIAN and Filipino"', add
label define raced_lbl 917 `"White, Black, and Filipino"', add
label define raced_lbl 920 `"White, Asian, other race write_in"', add
label define raced_lbl 921 `"White, Filipino, other race write_in (2000 1%)"', add
label define raced_lbl 922 `"White, Asian write_in, other race write_in (2000 1%)"', add
label define raced_lbl 923 `"Other White, Asian race(s), other race write_in (2000 1%)"', add
label define raced_lbl 925 `"White, PI, other race write_in"', add
label define raced_lbl 930 `"Black, AIAN, Asian"', add
label define raced_lbl 931 `"Black, AIAN, PI"', add
label define raced_lbl 932 `"Black, AIAN, other race write_in"', add
label define raced_lbl 933 `"Black, Asian, PI"', add
label define raced_lbl 934 `"Black, Asian, other race write_in"', add
label define raced_lbl 935 `"Black, PI, other race write_in"', add
label define raced_lbl 940 `"AIAN, Asian, PI"', add
label define raced_lbl 941 `"AIAN, Asian, other race write_in"', add
label define raced_lbl 942 `"AIAN, PI, other race write_in"', add
label define raced_lbl 943 `"Asian, PI, other race write_in"', add
label define raced_lbl 944 `"Asian (Chinese, Japanese, Korean, Vietnamese); and Native Hawaiian or PI; and Other"', add
label define raced_lbl 949 `"2 or 3 races (CPS)"', add
label define raced_lbl 950 `"White, Black, AIAN, Asian"', add
label define raced_lbl 951 `"White, Black, AIAN, PI"', add
label define raced_lbl 952 `"White, Black, AIAN, other race write_in"', add
label define raced_lbl 953 `"White, Black, Asian, PI"', add
label define raced_lbl 954 `"White, Black, Asian, other race write_in"', add
label define raced_lbl 955 `"White, Black, PI, other race write_in"', add
label define raced_lbl 960 `"White, AIAN, Asian, PI"', add
label define raced_lbl 961 `"White, AIAN, Asian, other race write_in"', add
label define raced_lbl 962 `"White, AIAN, PI, other race write_in"', add
label define raced_lbl 963 `"White, Asian, PI, other race write_in"', add
label define raced_lbl 964 `"White, Chinese, Japanese, Native Hawaiian"', add
label define raced_lbl 970 `"Black, AIAN, Asian, PI"', add
label define raced_lbl 971 `"Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 972 `"Black, AIAN, PI, other race write_in"', add
label define raced_lbl 973 `"Black, Asian, PI, other race write_in"', add
label define raced_lbl 974 `"AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 975 `"AIAN, Asian, PI, Hawaiian other race write_in"', add
label define raced_lbl 976 `"Two specified Asian  (Chinese and other Asian, Chinese and Japanese, Japanese and other Asian, Korean and other Asian); Native Hawaiian/PI; and Other Race"', add
label define raced_lbl 980 `"White, Black, AIAN, Asian, PI"', add
label define raced_lbl 981 `"White, Black, AIAN, Asian, other race write_in"', add
label define raced_lbl 982 `"White, Black, AIAN, PI, other race write_in"', add
label define raced_lbl 983 `"White, Black, Asian, PI, other race write_in"', add
label define raced_lbl 984 `"White, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 985 `"Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 986 `"Black, AIAN, Asian, PI, Hawaiian, other race write_in"', add
label define raced_lbl 989 `"4 or 5 races (CPS)"', add
label define raced_lbl 990 `"White, Black, AIAN, Asian, PI, other race write_in"', add
label define raced_lbl 991 `"White race; Some other race; Black or African American race and/or American Indian and Alaska Native race and/or Asian groups and/or Native Hawaiian and Other Pacific Islander groups"', add
label define raced_lbl 996 `"2+ races, n.e.c. (CPS)"', add
label values raced raced_lbl

label define hispan_lbl 0 `"Not Hispanic"'
label define hispan_lbl 1 `"Mexican"', add
label define hispan_lbl 2 `"Puerto Rican"', add
label define hispan_lbl 3 `"Cuban"', add
label define hispan_lbl 4 `"Other"', add
label define hispan_lbl 9 `"Not Reported"', add
label values hispan hispan_lbl

label define hispand_lbl 000 `"Not Hispanic"'
label define hispand_lbl 100 `"Mexican"', add
label define hispand_lbl 102 `"Mexican American"', add
label define hispand_lbl 103 `"Mexicano/Mexicana"', add
label define hispand_lbl 104 `"Chicano/Chicana"', add
label define hispand_lbl 105 `"La Raza"', add
label define hispand_lbl 106 `"Mexican American Indian"', add
label define hispand_lbl 107 `"Mexico"', add
label define hispand_lbl 200 `"Puerto Rican"', add
label define hispand_lbl 300 `"Cuban"', add
label define hispand_lbl 401 `"Central American Indian"', add
label define hispand_lbl 402 `"Canal Zone"', add
label define hispand_lbl 411 `"Costa Rican"', add
label define hispand_lbl 412 `"Guatemalan"', add
label define hispand_lbl 413 `"Honduran"', add
label define hispand_lbl 414 `"Nicaraguan"', add
label define hispand_lbl 415 `"Panamanian"', add
label define hispand_lbl 416 `"Salvadoran"', add
label define hispand_lbl 417 `"Central American, n.e.c."', add
label define hispand_lbl 420 `"Argentinean"', add
label define hispand_lbl 421 `"Bolivian"', add
label define hispand_lbl 422 `"Chilean"', add
label define hispand_lbl 423 `"Colombian"', add
label define hispand_lbl 424 `"Ecuadorian"', add
label define hispand_lbl 425 `"Paraguayan"', add
label define hispand_lbl 426 `"Peruvian"', add
label define hispand_lbl 427 `"Uruguayan"', add
label define hispand_lbl 428 `"Venezuelan"', add
label define hispand_lbl 429 `"South American Indian"', add
label define hispand_lbl 430 `"Criollo"', add
label define hispand_lbl 431 `"South American, n.e.c."', add
label define hispand_lbl 450 `"Spaniard"', add
label define hispand_lbl 451 `"Andalusian"', add
label define hispand_lbl 452 `"Asturian"', add
label define hispand_lbl 453 `"Castillian"', add
label define hispand_lbl 454 `"Catalonian"', add
label define hispand_lbl 455 `"Balearic Islander"', add
label define hispand_lbl 456 `"Gallego"', add
label define hispand_lbl 457 `"Valencian"', add
label define hispand_lbl 458 `"Canarian"', add
label define hispand_lbl 459 `"Spanish Basque"', add
label define hispand_lbl 460 `"Dominican"', add
label define hispand_lbl 465 `"Latin American"', add
label define hispand_lbl 470 `"Hispanic"', add
label define hispand_lbl 480 `"Spanish"', add
label define hispand_lbl 490 `"Californio"', add
label define hispand_lbl 491 `"Tejano"', add
label define hispand_lbl 492 `"Nuevo Mexicano"', add
label define hispand_lbl 493 `"Spanish American"', add
label define hispand_lbl 494 `"Spanish American Indian"', add
label define hispand_lbl 495 `"Meso American Indian"', add
label define hispand_lbl 496 `"Mestizo"', add
label define hispand_lbl 498 `"Other, n.s."', add
label define hispand_lbl 499 `"Other, n.e.c."', add
label define hispand_lbl 900 `"Not Reported"', add
label values hispand hispand_lbl

label define bpl_lbl 001 `"Alabama"'
label define bpl_lbl 002 `"Alaska"', add
label define bpl_lbl 004 `"Arizona"', add
label define bpl_lbl 005 `"Arkansas"', add
label define bpl_lbl 006 `"California"', add
label define bpl_lbl 008 `"Colorado"', add
label define bpl_lbl 009 `"Connecticut"', add
label define bpl_lbl 010 `"Delaware"', add
label define bpl_lbl 011 `"District of Columbia"', add
label define bpl_lbl 012 `"Florida"', add
label define bpl_lbl 013 `"Georgia"', add
label define bpl_lbl 015 `"Hawaii"', add
label define bpl_lbl 016 `"Idaho"', add
label define bpl_lbl 017 `"Illinois"', add
label define bpl_lbl 018 `"Indiana"', add
label define bpl_lbl 019 `"Iowa"', add
label define bpl_lbl 020 `"Kansas"', add
label define bpl_lbl 021 `"Kentucky"', add
label define bpl_lbl 022 `"Louisiana"', add
label define bpl_lbl 023 `"Maine"', add
label define bpl_lbl 024 `"Maryland"', add
label define bpl_lbl 025 `"Massachusetts"', add
label define bpl_lbl 026 `"Michigan"', add
label define bpl_lbl 027 `"Minnesota"', add
label define bpl_lbl 028 `"Mississippi"', add
label define bpl_lbl 029 `"Missouri"', add
label define bpl_lbl 030 `"Montana"', add
label define bpl_lbl 031 `"Nebraska"', add
label define bpl_lbl 032 `"Nevada"', add
label define bpl_lbl 033 `"New Hampshire"', add
label define bpl_lbl 034 `"New Jersey"', add
label define bpl_lbl 035 `"New Mexico"', add
label define bpl_lbl 036 `"New York"', add
label define bpl_lbl 037 `"North Carolina"', add
label define bpl_lbl 038 `"North Dakota"', add
label define bpl_lbl 039 `"Ohio"', add
label define bpl_lbl 040 `"Oklahoma"', add
label define bpl_lbl 041 `"Oregon"', add
label define bpl_lbl 042 `"Pennsylvania"', add
label define bpl_lbl 044 `"Rhode Island"', add
label define bpl_lbl 045 `"South Carolina"', add
label define bpl_lbl 046 `"South Dakota"', add
label define bpl_lbl 047 `"Tennessee"', add
label define bpl_lbl 048 `"Texas"', add
label define bpl_lbl 049 `"Utah"', add
label define bpl_lbl 050 `"Vermont"', add
label define bpl_lbl 051 `"Virginia"', add
label define bpl_lbl 053 `"Washington"', add
label define bpl_lbl 054 `"West Virginia"', add
label define bpl_lbl 055 `"Wisconsin"', add
label define bpl_lbl 056 `"Wyoming"', add
label define bpl_lbl 090 `"Native American"', add
label define bpl_lbl 099 `"United States, ns"', add
label define bpl_lbl 100 `"American Samoa"', add
label define bpl_lbl 105 `"Guam"', add
label define bpl_lbl 110 `"Puerto Rico"', add
label define bpl_lbl 115 `"U.S. Virgin Islands"', add
label define bpl_lbl 120 `"Other US Possessions"', add
label define bpl_lbl 150 `"Canada"', add
label define bpl_lbl 155 `"St. Pierre and Miquelon"', add
label define bpl_lbl 160 `"Atlantic Islands"', add
label define bpl_lbl 199 `"North America, ns"', add
label define bpl_lbl 200 `"Mexico"', add
label define bpl_lbl 210 `"Central America"', add
label define bpl_lbl 250 `"Cuba"', add
label define bpl_lbl 260 `"West Indies"', add
label define bpl_lbl 299 `"Americas, n.s."', add
label define bpl_lbl 300 `"SOUTH AMERICA"', add
label define bpl_lbl 400 `"Denmark"', add
label define bpl_lbl 401 `"Finland"', add
label define bpl_lbl 402 `"Iceland"', add
label define bpl_lbl 403 `"Lapland, n.s."', add
label define bpl_lbl 404 `"Norway"', add
label define bpl_lbl 405 `"Sweden"', add
label define bpl_lbl 410 `"England"', add
label define bpl_lbl 411 `"Scotland"', add
label define bpl_lbl 412 `"Wales"', add
label define bpl_lbl 413 `"United Kingdom, ns"', add
label define bpl_lbl 414 `"Ireland"', add
label define bpl_lbl 419 `"Northern Europe, ns"', add
label define bpl_lbl 420 `"Belgium"', add
label define bpl_lbl 421 `"France"', add
label define bpl_lbl 422 `"Liechtenstein"', add
label define bpl_lbl 423 `"Luxembourg"', add
label define bpl_lbl 424 `"Monaco"', add
label define bpl_lbl 425 `"Netherlands"', add
label define bpl_lbl 426 `"Switzerland"', add
label define bpl_lbl 429 `"Western Europe, ns"', add
label define bpl_lbl 430 `"Albania"', add
label define bpl_lbl 431 `"Andorra"', add
label define bpl_lbl 432 `"Gibraltar"', add
label define bpl_lbl 433 `"Greece"', add
label define bpl_lbl 434 `"Italy"', add
label define bpl_lbl 435 `"Malta"', add
label define bpl_lbl 436 `"Portugal"', add
label define bpl_lbl 437 `"San Marino"', add
label define bpl_lbl 438 `"Spain"', add
label define bpl_lbl 439 `"Vatican City"', add
label define bpl_lbl 440 `"Southern Europe, ns"', add
label define bpl_lbl 450 `"Austria"', add
label define bpl_lbl 451 `"Bulgaria"', add
label define bpl_lbl 452 `"Czechoslovakia"', add
label define bpl_lbl 453 `"Germany"', add
label define bpl_lbl 454 `"Hungary"', add
label define bpl_lbl 455 `"Poland"', add
label define bpl_lbl 456 `"Romania"', add
label define bpl_lbl 457 `"Yugoslavia"', add
label define bpl_lbl 458 `"Central Europe, ns"', add
label define bpl_lbl 459 `"Eastern Europe, ns"', add
label define bpl_lbl 460 `"Estonia"', add
label define bpl_lbl 461 `"Latvia"', add
label define bpl_lbl 462 `"Lithuania"', add
label define bpl_lbl 463 `"Baltic States, ns"', add
label define bpl_lbl 465 `"Other USSR/Russia"', add
label define bpl_lbl 499 `"Europe, ns"', add
label define bpl_lbl 500 `"China"', add
label define bpl_lbl 501 `"Japan"', add
label define bpl_lbl 502 `"Korea"', add
label define bpl_lbl 509 `"East Asia, ns"', add
label define bpl_lbl 510 `"Brunei"', add
label define bpl_lbl 511 `"Cambodia (Kampuchea)"', add
label define bpl_lbl 512 `"Indonesia"', add
label define bpl_lbl 513 `"Laos"', add
label define bpl_lbl 514 `"Malaysia"', add
label define bpl_lbl 515 `"Philippines"', add
label define bpl_lbl 516 `"Singapore"', add
label define bpl_lbl 517 `"Thailand"', add
label define bpl_lbl 518 `"Vietnam"', add
label define bpl_lbl 519 `"Southeast Asia, ns"', add
label define bpl_lbl 520 `"Afghanistan"', add
label define bpl_lbl 521 `"India"', add
label define bpl_lbl 522 `"Iran"', add
label define bpl_lbl 523 `"Maldives"', add
label define bpl_lbl 524 `"Nepal"', add
label define bpl_lbl 530 `"Bahrain"', add
label define bpl_lbl 531 `"Cyprus"', add
label define bpl_lbl 532 `"Iraq"', add
label define bpl_lbl 533 `"Iraq/Saudi Arabia"', add
label define bpl_lbl 534 `"Israel/Palestine"', add
label define bpl_lbl 535 `"Jordan"', add
label define bpl_lbl 536 `"Kuwait"', add
label define bpl_lbl 537 `"Lebanon"', add
label define bpl_lbl 538 `"Oman"', add
label define bpl_lbl 539 `"Qatar"', add
label define bpl_lbl 540 `"Saudi Arabia"', add
label define bpl_lbl 541 `"Syria"', add
label define bpl_lbl 542 `"Turkey"', add
label define bpl_lbl 543 `"United Arab Emirates"', add
label define bpl_lbl 544 `"Yemen Arab Republic (North)"', add
label define bpl_lbl 545 `"Yemen, PDR (South)"', add
label define bpl_lbl 546 `"Persian Gulf States, n.s."', add
label define bpl_lbl 547 `"Middle East, ns"', add
label define bpl_lbl 548 `"Southwest Asia, nec/ns"', add
label define bpl_lbl 549 `"Asia Minor, ns"', add
label define bpl_lbl 550 `"South Asia, nec"', add
label define bpl_lbl 599 `"Asia, nec/ns"', add
label define bpl_lbl 600 `"AFRICA"', add
label define bpl_lbl 700 `"Australia and New Zealand"', add
label define bpl_lbl 710 `"Pacific Islands"', add
label define bpl_lbl 800 `"Antarctica, ns/nec"', add
label define bpl_lbl 900 `"Abroad (unknown) or at sea"', add
label define bpl_lbl 950 `"Other n.e.c."', add
label define bpl_lbl 999 `"Missing/blank"', add
label values bpl bpl_lbl

label define bpld_lbl 00100 `"Alabama"'
label define bpld_lbl 00200 `"Alaska"', add
label define bpld_lbl 00400 `"Arizona"', add
label define bpld_lbl 00500 `"Arkansas"', add
label define bpld_lbl 00600 `"California"', add
label define bpld_lbl 00800 `"Colorado"', add
label define bpld_lbl 00900 `"Connecticut"', add
label define bpld_lbl 01000 `"Delaware"', add
label define bpld_lbl 01100 `"District of Columbia"', add
label define bpld_lbl 01200 `"Florida"', add
label define bpld_lbl 01300 `"Georgia"', add
label define bpld_lbl 01500 `"Hawaii"', add
label define bpld_lbl 01600 `"Idaho"', add
label define bpld_lbl 01610 `"Idaho Territory"', add
label define bpld_lbl 01700 `"Illinois"', add
label define bpld_lbl 01800 `"Indiana"', add
label define bpld_lbl 01900 `"Iowa"', add
label define bpld_lbl 02000 `"Kansas"', add
label define bpld_lbl 02100 `"Kentucky"', add
label define bpld_lbl 02200 `"Louisiana"', add
label define bpld_lbl 02300 `"Maine"', add
label define bpld_lbl 02400 `"Maryland"', add
label define bpld_lbl 02500 `"Massachusetts"', add
label define bpld_lbl 02600 `"Michigan"', add
label define bpld_lbl 02700 `"Minnesota"', add
label define bpld_lbl 02800 `"Mississippi"', add
label define bpld_lbl 02900 `"Missouri"', add
label define bpld_lbl 03000 `"Montana"', add
label define bpld_lbl 03100 `"Nebraska"', add
label define bpld_lbl 03200 `"Nevada"', add
label define bpld_lbl 03300 `"New Hampshire"', add
label define bpld_lbl 03400 `"New Jersey"', add
label define bpld_lbl 03500 `"New Mexico"', add
label define bpld_lbl 03510 `"New Mexico Territory"', add
label define bpld_lbl 03600 `"New York"', add
label define bpld_lbl 03700 `"North Carolina"', add
label define bpld_lbl 03800 `"North Dakota"', add
label define bpld_lbl 03900 `"Ohio"', add
label define bpld_lbl 04000 `"Oklahoma"', add
label define bpld_lbl 04010 `"Indian Territory"', add
label define bpld_lbl 04100 `"Oregon"', add
label define bpld_lbl 04200 `"Pennsylvania"', add
label define bpld_lbl 04400 `"Rhode Island"', add
label define bpld_lbl 04500 `"South Carolina"', add
label define bpld_lbl 04600 `"South Dakota"', add
label define bpld_lbl 04610 `"Dakota Territory"', add
label define bpld_lbl 04700 `"Tennessee"', add
label define bpld_lbl 04800 `"Texas"', add
label define bpld_lbl 04900 `"Utah"', add
label define bpld_lbl 04910 `"Utah Territory"', add
label define bpld_lbl 05000 `"Vermont"', add
label define bpld_lbl 05100 `"Virginia"', add
label define bpld_lbl 05300 `"Washington"', add
label define bpld_lbl 05400 `"West Virginia"', add
label define bpld_lbl 05500 `"Wisconsin"', add
label define bpld_lbl 05600 `"Wyoming"', add
label define bpld_lbl 05610 `"Wyoming Territory"', add
label define bpld_lbl 09000 `"Native American"', add
label define bpld_lbl 09900 `"United States, ns"', add
label define bpld_lbl 10000 `"American Samoa"', add
label define bpld_lbl 10010 `"Samoa, 1940-1950"', add
label define bpld_lbl 10500 `"Guam"', add
label define bpld_lbl 11000 `"Puerto Rico"', add
label define bpld_lbl 11500 `"U.S. Virgin Islands"', add
label define bpld_lbl 11510 `"St. Croix"', add
label define bpld_lbl 11520 `"St. John"', add
label define bpld_lbl 11530 `"St. Thomas"', add
label define bpld_lbl 12000 `"Other US Possessions:"', add
label define bpld_lbl 12010 `"Johnston Atoll"', add
label define bpld_lbl 12020 `"Midway Islands"', add
label define bpld_lbl 12030 `"Wake Island"', add
label define bpld_lbl 12040 `"Other US Caribbean Islands"', add
label define bpld_lbl 12041 `"Navassa Island"', add
label define bpld_lbl 12050 `"Other US Pacific Islands"', add
label define bpld_lbl 12051 `"Baker Island"', add
label define bpld_lbl 12052 `"Howland Island"', add
label define bpld_lbl 12053 `"Jarvis Island"', add
label define bpld_lbl 12054 `"Kingman Reef"', add
label define bpld_lbl 12055 `"Palmyra Atoll"', add
label define bpld_lbl 12056 `"Canton and Enderbury Island"', add
label define bpld_lbl 12090 `"US outlying areas, ns"', add
label define bpld_lbl 12091 `"US possessions, ns"', add
label define bpld_lbl 12092 `"US territory, ns"', add
label define bpld_lbl 15000 `"Canada"', add
label define bpld_lbl 15010 `"English Canada"', add
label define bpld_lbl 15011 `"British Columbia"', add
label define bpld_lbl 15013 `"Alberta"', add
label define bpld_lbl 15015 `"Saskatchewan"', add
label define bpld_lbl 15017 `"Northwest"', add
label define bpld_lbl 15019 `"Ruperts Land"', add
label define bpld_lbl 15020 `"Manitoba"', add
label define bpld_lbl 15021 `"Red River"', add
label define bpld_lbl 15030 `"Ontario/Upper Canada"', add
label define bpld_lbl 15031 `"Upper Canada"', add
label define bpld_lbl 15032 `"Canada West"', add
label define bpld_lbl 15040 `"New Brunswick"', add
label define bpld_lbl 15050 `"Nova Scotia"', add
label define bpld_lbl 15051 `"Cape Breton"', add
label define bpld_lbl 15052 `"Halifax"', add
label define bpld_lbl 15060 `"Prince Edward Island"', add
label define bpld_lbl 15070 `"Newfoundland"', add
label define bpld_lbl 15080 `"French Canada"', add
label define bpld_lbl 15081 `"Quebec"', add
label define bpld_lbl 15082 `"Lower Canada"', add
label define bpld_lbl 15083 `"Canada East"', add
label define bpld_lbl 15500 `"St. Pierre and Miquelon"', add
label define bpld_lbl 16000 `"Atlantic Islands"', add
label define bpld_lbl 16010 `"Bermuda"', add
label define bpld_lbl 16020 `"Cape Verde"', add
label define bpld_lbl 16030 `"Falkland Islands"', add
label define bpld_lbl 16040 `"Greenland"', add
label define bpld_lbl 16050 `"St. Helena and Ascension"', add
label define bpld_lbl 16060 `"Canary Islands"', add
label define bpld_lbl 19900 `"North America, ns"', add
label define bpld_lbl 20000 `"Mexico"', add
label define bpld_lbl 21000 `"Central America"', add
label define bpld_lbl 21010 `"Belize/British Honduras"', add
label define bpld_lbl 21020 `"Costa Rica"', add
label define bpld_lbl 21030 `"El Salvador"', add
label define bpld_lbl 21040 `"Guatemala"', add
label define bpld_lbl 21050 `"Honduras"', add
label define bpld_lbl 21060 `"Nicaragua"', add
label define bpld_lbl 21070 `"Panama"', add
label define bpld_lbl 21071 `"Canal Zone"', add
label define bpld_lbl 21090 `"Central America, ns"', add
label define bpld_lbl 25000 `"Cuba"', add
label define bpld_lbl 26000 `"West Indies"', add
label define bpld_lbl 26010 `"Dominican Republic"', add
label define bpld_lbl 26020 `"Haiti"', add
label define bpld_lbl 26030 `"Jamaica"', add
label define bpld_lbl 26040 `"British West Indies"', add
label define bpld_lbl 26041 `"Anguilla"', add
label define bpld_lbl 26042 `"Antigua-Barbuda"', add
label define bpld_lbl 26043 `"Bahamas"', add
label define bpld_lbl 26044 `"Barbados"', add
label define bpld_lbl 26045 `"British Virgin Islands"', add
label define bpld_lbl 26046 `"Anegada"', add
label define bpld_lbl 26047 `"Cooper"', add
label define bpld_lbl 26048 `"Jost Van Dyke"', add
label define bpld_lbl 26049 `"Peter"', add
label define bpld_lbl 26050 `"Tortola"', add
label define bpld_lbl 26051 `"Virgin Gorda"', add
label define bpld_lbl 26052 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26053 `"Cayman Islands"', add
label define bpld_lbl 26054 `"Dominica"', add
label define bpld_lbl 26055 `"Grenada"', add
label define bpld_lbl 26056 `"Montserrat"', add
label define bpld_lbl 26057 `"St. Kitts-Nevis"', add
label define bpld_lbl 26058 `"St. Lucia"', add
label define bpld_lbl 26059 `"St. Vincent"', add
label define bpld_lbl 26060 `"Trinidad and Tobago"', add
label define bpld_lbl 26061 `"Turks and Caicos"', add
label define bpld_lbl 26069 `"Br. Virgin Islands, ns"', add
label define bpld_lbl 26070 `"Other West Indies"', add
label define bpld_lbl 26071 `"Aruba"', add
label define bpld_lbl 26072 `"Netherlands Antilles"', add
label define bpld_lbl 26073 `"Bonaire"', add
label define bpld_lbl 26074 `"Curacao"', add
label define bpld_lbl 26075 `"Dutch St. Maarten"', add
label define bpld_lbl 26076 `"Saba"', add
label define bpld_lbl 26077 `"St. Eustatius"', add
label define bpld_lbl 26079 `"Dutch Caribbean, ns"', add
label define bpld_lbl 26080 `"French St. Maarten"', add
label define bpld_lbl 26081 `"Guadeloupe"', add
label define bpld_lbl 26082 `"Martinique"', add
label define bpld_lbl 26083 `"St. Barthelemy"', add
label define bpld_lbl 26089 `"French Caribbean, ns"', add
label define bpld_lbl 26090 `"Antilles, ns"', add
label define bpld_lbl 26091 `"Caribbean, ns"', add
label define bpld_lbl 26092 `"Latin America, ns"', add
label define bpld_lbl 26093 `"Leeward Islands, ns"', add
label define bpld_lbl 26094 `"West Indies, ns"', add
label define bpld_lbl 26095 `"Windward Islands, ns"', add
label define bpld_lbl 29900 `"Americas, ns"', add
label define bpld_lbl 30000 `"South America"', add
label define bpld_lbl 30005 `"Argentina"', add
label define bpld_lbl 30010 `"Bolivia"', add
label define bpld_lbl 30015 `"Brazil"', add
label define bpld_lbl 30020 `"Chile"', add
label define bpld_lbl 30025 `"Colombia"', add
label define bpld_lbl 30030 `"Ecuador"', add
label define bpld_lbl 30035 `"French Guiana"', add
label define bpld_lbl 30040 `"Guyana/British Guiana"', add
label define bpld_lbl 30045 `"Paraguay"', add
label define bpld_lbl 30050 `"Peru"', add
label define bpld_lbl 30055 `"Suriname"', add
label define bpld_lbl 30060 `"Uruguay"', add
label define bpld_lbl 30065 `"Venezuela"', add
label define bpld_lbl 30090 `"South America, ns"', add
label define bpld_lbl 30091 `"South and Central America, n.s."', add
label define bpld_lbl 40000 `"Denmark"', add
label define bpld_lbl 40010 `"Faeroe Islands"', add
label define bpld_lbl 40100 `"Finland"', add
label define bpld_lbl 40200 `"Iceland"', add
label define bpld_lbl 40300 `"Lapland, ns"', add
label define bpld_lbl 40400 `"Norway"', add
label define bpld_lbl 40410 `"Svalbard and Jan Meyen"', add
label define bpld_lbl 40411 `"Svalbard"', add
label define bpld_lbl 40412 `"Jan Meyen"', add
label define bpld_lbl 40500 `"Sweden"', add
label define bpld_lbl 41000 `"England"', add
label define bpld_lbl 41010 `"Channel Islands"', add
label define bpld_lbl 41011 `"Guernsey"', add
label define bpld_lbl 41012 `"Jersey"', add
label define bpld_lbl 41020 `"Isle of Man"', add
label define bpld_lbl 41100 `"Scotland"', add
label define bpld_lbl 41200 `"Wales"', add
label define bpld_lbl 41300 `"United Kingdom, ns"', add
label define bpld_lbl 41400 `"Ireland"', add
label define bpld_lbl 41410 `"Northern Ireland"', add
label define bpld_lbl 41900 `"Northern Europe, ns"', add
label define bpld_lbl 42000 `"Belgium"', add
label define bpld_lbl 42100 `"France"', add
label define bpld_lbl 42110 `"Alsace-Lorraine"', add
label define bpld_lbl 42111 `"Alsace"', add
label define bpld_lbl 42112 `"Lorraine"', add
label define bpld_lbl 42200 `"Liechtenstein"', add
label define bpld_lbl 42300 `"Luxembourg"', add
label define bpld_lbl 42400 `"Monaco"', add
label define bpld_lbl 42500 `"Netherlands"', add
label define bpld_lbl 42600 `"Switzerland"', add
label define bpld_lbl 42900 `"Western Europe, ns"', add
label define bpld_lbl 43000 `"Albania"', add
label define bpld_lbl 43100 `"Andorra"', add
label define bpld_lbl 43200 `"Gibraltar"', add
label define bpld_lbl 43300 `"Greece"', add
label define bpld_lbl 43310 `"Dodecanese Islands"', add
label define bpld_lbl 43320 `"Turkey Greece"', add
label define bpld_lbl 43330 `"Macedonia"', add
label define bpld_lbl 43400 `"Italy"', add
label define bpld_lbl 43500 `"Malta"', add
label define bpld_lbl 43600 `"Portugal"', add
label define bpld_lbl 43610 `"Azores"', add
label define bpld_lbl 43620 `"Madeira Islands"', add
label define bpld_lbl 43630 `"Cape Verde Islands"', add
label define bpld_lbl 43640 `"St. Miguel"', add
label define bpld_lbl 43700 `"San Marino"', add
label define bpld_lbl 43800 `"Spain"', add
label define bpld_lbl 43900 `"Vatican City"', add
label define bpld_lbl 44000 `"Southern Europe, ns"', add
label define bpld_lbl 45000 `"Austria"', add
label define bpld_lbl 45010 `"Austria-Hungary"', add
label define bpld_lbl 45020 `"Austria-Graz"', add
label define bpld_lbl 45030 `"Austria-Linz"', add
label define bpld_lbl 45040 `"Austria-Salzburg"', add
label define bpld_lbl 45050 `"Austria-Tyrol"', add
label define bpld_lbl 45060 `"Austria-Vienna"', add
label define bpld_lbl 45070 `"Austria-Kaernsten"', add
label define bpld_lbl 45080 `"Austria-Neustadt"', add
label define bpld_lbl 45100 `"Bulgaria"', add
label define bpld_lbl 45200 `"Czechoslovakia"', add
label define bpld_lbl 45210 `"Bohemia"', add
label define bpld_lbl 45211 `"Bohemia-Moravia"', add
label define bpld_lbl 45212 `"Slovakia"', add
label define bpld_lbl 45213 `"Czech Republic"', add
label define bpld_lbl 45300 `"Germany"', add
label define bpld_lbl 45301 `"Berlin"', add
label define bpld_lbl 45302 `"West Berlin"', add
label define bpld_lbl 45303 `"East Berlin"', add
label define bpld_lbl 45310 `"West Germany"', add
label define bpld_lbl 45311 `"Baden"', add
label define bpld_lbl 45312 `"Bavaria"', add
label define bpld_lbl 45313 `"Braunschweig"', add
label define bpld_lbl 45314 `"Bremen"', add
label define bpld_lbl 45315 `"Hamburg"', add
label define bpld_lbl 45316 `"Hanover"', add
label define bpld_lbl 45317 `"Hessen"', add
label define bpld_lbl 45318 `"Hesse-Nassau"', add
label define bpld_lbl 45319 `"Lippe"', add
label define bpld_lbl 45320 `"Lubeck"', add
label define bpld_lbl 45321 `"Oldenburg"', add
label define bpld_lbl 45322 `"Rheinland"', add
label define bpld_lbl 45323 `"Schaumburg-Lippe"', add
label define bpld_lbl 45324 `"Schleswig"', add
label define bpld_lbl 45325 `"Sigmaringen"', add
label define bpld_lbl 45326 `"Schwarzburg"', add
label define bpld_lbl 45327 `"Westphalia"', add
label define bpld_lbl 45328 `"Wurttemberg"', add
label define bpld_lbl 45329 `"Waldeck"', add
label define bpld_lbl 45330 `"Wittenberg"', add
label define bpld_lbl 45331 `"Frankfurt"', add
label define bpld_lbl 45332 `"Saarland"', add
label define bpld_lbl 45333 `"Nordrhein-Westfalen"', add
label define bpld_lbl 45340 `"East Germany"', add
label define bpld_lbl 45341 `"Anhalt"', add
label define bpld_lbl 45342 `"Brandenburg"', add
label define bpld_lbl 45344 `"Kingdom of Saxony"', add
label define bpld_lbl 45345 `"Mecklenburg"', add
label define bpld_lbl 45346 `"Saxony"', add
label define bpld_lbl 45347 `"Thuringian States"', add
label define bpld_lbl 45348 `"Sachsen-Meiningen"', add
label define bpld_lbl 45349 `"Sachsen-Weimar-Eisenach"', add
label define bpld_lbl 45350 `"Probable Saxony"', add
label define bpld_lbl 45351 `"Schwerin"', add
label define bpld_lbl 45352 `"Strelitz"', add
label define bpld_lbl 45353 `"Probably Thuringian States"', add
label define bpld_lbl 45360 `"Prussia, nec"', add
label define bpld_lbl 45361 `"Hohenzollern"', add
label define bpld_lbl 45362 `"Niedersachsen"', add
label define bpld_lbl 45400 `"Hungary"', add
label define bpld_lbl 45500 `"Poland"', add
label define bpld_lbl 45510 `"Austrian Poland"', add
label define bpld_lbl 45511 `"Galicia"', add
label define bpld_lbl 45520 `"German Poland"', add
label define bpld_lbl 45521 `"East Prussia"', add
label define bpld_lbl 45522 `"Pomerania"', add
label define bpld_lbl 45523 `"Posen"', add
label define bpld_lbl 45524 `"Prussian Poland"', add
label define bpld_lbl 45525 `"Silesia"', add
label define bpld_lbl 45526 `"West Prussia"', add
label define bpld_lbl 45530 `"Russian Poland"', add
label define bpld_lbl 45600 `"Romania"', add
label define bpld_lbl 45610 `"Transylvania"', add
label define bpld_lbl 45700 `"Yugoslavia"', add
label define bpld_lbl 45710 `"Croatia"', add
label define bpld_lbl 45720 `"Montenegro"', add
label define bpld_lbl 45730 `"Serbia"', add
label define bpld_lbl 45740 `"Bosnia"', add
label define bpld_lbl 45750 `"Dalmatia"', add
label define bpld_lbl 45760 `"Slovonia"', add
label define bpld_lbl 45770 `"Carniola"', add
label define bpld_lbl 45780 `"Slovenia"', add
label define bpld_lbl 45790 `"Kosovo"', add
label define bpld_lbl 45800 `"Central Europe, ns"', add
label define bpld_lbl 45900 `"Eastern Europe, ns"', add
label define bpld_lbl 46000 `"Estonia"', add
label define bpld_lbl 46100 `"Latvia"', add
label define bpld_lbl 46200 `"Lithuania"', add
label define bpld_lbl 46300 `"Baltic States, ns"', add
label define bpld_lbl 46500 `"Other USSR/Russia"', add
label define bpld_lbl 46510 `"Byelorussia"', add
label define bpld_lbl 46520 `"Moldavia"', add
label define bpld_lbl 46521 `"Bessarabia"', add
label define bpld_lbl 46530 `"Ukraine"', add
label define bpld_lbl 46540 `"Armenia"', add
label define bpld_lbl 46541 `"Azerbaijan"', add
label define bpld_lbl 46542 `"Republic of Georgia"', add
label define bpld_lbl 46543 `"Kazakhstan"', add
label define bpld_lbl 46544 `"Kirghizia"', add
label define bpld_lbl 46545 `"Tadzhik"', add
label define bpld_lbl 46546 `"Turkmenistan"', add
label define bpld_lbl 46547 `"Uzbekistan"', add
label define bpld_lbl 46548 `"Siberia"', add
label define bpld_lbl 46590 `"USSR, ns"', add
label define bpld_lbl 49900 `"Europe, ns."', add
label define bpld_lbl 50000 `"China"', add
label define bpld_lbl 50010 `"Hong Kong"', add
label define bpld_lbl 50020 `"Macau"', add
label define bpld_lbl 50030 `"Mongolia"', add
label define bpld_lbl 50040 `"Taiwan"', add
label define bpld_lbl 50100 `"Japan"', add
label define bpld_lbl 50200 `"Korea"', add
label define bpld_lbl 50210 `"North Korea"', add
label define bpld_lbl 50220 `"South Korea"', add
label define bpld_lbl 50900 `"East Asia, ns"', add
label define bpld_lbl 51000 `"Brunei"', add
label define bpld_lbl 51100 `"Cambodia (Kampuchea)"', add
label define bpld_lbl 51200 `"Indonesia"', add
label define bpld_lbl 51210 `"East Indies"', add
label define bpld_lbl 51220 `"East Timor"', add
label define bpld_lbl 51300 `"Laos"', add
label define bpld_lbl 51400 `"Malaysia"', add
label define bpld_lbl 51500 `"Philippines"', add
label define bpld_lbl 51600 `"Singapore"', add
label define bpld_lbl 51700 `"Thailand"', add
label define bpld_lbl 51800 `"Vietnam"', add
label define bpld_lbl 51900 `"Southeast Asia, ns"', add
label define bpld_lbl 51910 `"Indochina, ns"', add
label define bpld_lbl 52000 `"Afghanistan"', add
label define bpld_lbl 52100 `"India"', add
label define bpld_lbl 52110 `"Bangladesh"', add
label define bpld_lbl 52120 `"Bhutan"', add
label define bpld_lbl 52130 `"Burma (Myanmar)"', add
label define bpld_lbl 52140 `"Pakistan"', add
label define bpld_lbl 52150 `"Sri Lanka (Ceylon)"', add
label define bpld_lbl 52200 `"Iran"', add
label define bpld_lbl 52300 `"Maldives"', add
label define bpld_lbl 52400 `"Nepal"', add
label define bpld_lbl 53000 `"Bahrain"', add
label define bpld_lbl 53100 `"Cyprus"', add
label define bpld_lbl 53200 `"Iraq"', add
label define bpld_lbl 53210 `"Mesopotamia"', add
label define bpld_lbl 53300 `"Iraq/Saudi Arabia"', add
label define bpld_lbl 53400 `"Israel/Palestine"', add
label define bpld_lbl 53410 `"Gaza Strip"', add
label define bpld_lbl 53420 `"Palestine"', add
label define bpld_lbl 53430 `"West Bank"', add
label define bpld_lbl 53440 `"Israel"', add
label define bpld_lbl 53500 `"Jordan"', add
label define bpld_lbl 53600 `"Kuwait"', add
label define bpld_lbl 53700 `"Lebanon"', add
label define bpld_lbl 53800 `"Oman"', add
label define bpld_lbl 53900 `"Qatar"', add
label define bpld_lbl 54000 `"Saudi Arabia"', add
label define bpld_lbl 54100 `"Syria"', add
label define bpld_lbl 54200 `"Turkey"', add
label define bpld_lbl 54210 `"European Turkey"', add
label define bpld_lbl 54220 `"Asian Turkey"', add
label define bpld_lbl 54300 `"United Arab Emirates"', add
label define bpld_lbl 54400 `"Yemen Arab Republic (North)"', add
label define bpld_lbl 54500 `"Yemen, PDR (South)"', add
label define bpld_lbl 54600 `"Persian Gulf States, ns"', add
label define bpld_lbl 54700 `"Middle East, ns"', add
label define bpld_lbl 54800 `"Southwest Asia, nec/ns"', add
label define bpld_lbl 54900 `"Asia Minor, ns"', add
label define bpld_lbl 55000 `"South Asia, nec"', add
label define bpld_lbl 59900 `"Asia, nec/ns"', add
label define bpld_lbl 60000 `"Africa"', add
label define bpld_lbl 60010 `"Northern Africa"', add
label define bpld_lbl 60011 `"Algeria"', add
label define bpld_lbl 60012 `"Egypt/United Arab Rep."', add
label define bpld_lbl 60013 `"Libya"', add
label define bpld_lbl 60014 `"Morocco"', add
label define bpld_lbl 60015 `"Sudan"', add
label define bpld_lbl 60016 `"Tunisia"', add
label define bpld_lbl 60017 `"Western Sahara"', add
label define bpld_lbl 60019 `"North Africa, ns"', add
label define bpld_lbl 60020 `"Benin"', add
label define bpld_lbl 60021 `"Burkina Faso"', add
label define bpld_lbl 60022 `"Gambia"', add
label define bpld_lbl 60023 `"Ghana"', add
label define bpld_lbl 60024 `"Guinea"', add
label define bpld_lbl 60025 `"Guinea-Bissau"', add
label define bpld_lbl 60026 `"Ivory Coast"', add
label define bpld_lbl 60027 `"Liberia"', add
label define bpld_lbl 60028 `"Mali"', add
label define bpld_lbl 60029 `"Mauritania"', add
label define bpld_lbl 60030 `"Niger"', add
label define bpld_lbl 60031 `"Nigeria"', add
label define bpld_lbl 60032 `"Senegal"', add
label define bpld_lbl 60033 `"Sierra Leone"', add
label define bpld_lbl 60034 `"Togo"', add
label define bpld_lbl 60038 `"Western Africa, ns"', add
label define bpld_lbl 60039 `"French West Africa, ns"', add
label define bpld_lbl 60040 `"British Indian Ocean Territory"', add
label define bpld_lbl 60041 `"Burundi"', add
label define bpld_lbl 60042 `"Comoros"', add
label define bpld_lbl 60043 `"Djibouti"', add
label define bpld_lbl 60044 `"Ethiopia"', add
label define bpld_lbl 60045 `"Kenya"', add
label define bpld_lbl 60046 `"Madagascar"', add
label define bpld_lbl 60047 `"Malawi"', add
label define bpld_lbl 60048 `"Mauritius"', add
label define bpld_lbl 60049 `"Mozambique"', add
label define bpld_lbl 60050 `"Reunion"', add
label define bpld_lbl 60051 `"Rwanda"', add
label define bpld_lbl 60052 `"Seychelles"', add
label define bpld_lbl 60053 `"Somalia"', add
label define bpld_lbl 60054 `"Tanzania"', add
label define bpld_lbl 60055 `"Uganda"', add
label define bpld_lbl 60056 `"Zambia"', add
label define bpld_lbl 60057 `"Zimbabwe"', add
label define bpld_lbl 60058 `"Bassas de India"', add
label define bpld_lbl 60059 `"Europa"', add
label define bpld_lbl 60060 `"Gloriosos"', add
label define bpld_lbl 60061 `"Juan de Nova"', add
label define bpld_lbl 60062 `"Mayotte"', add
label define bpld_lbl 60063 `"Tromelin"', add
label define bpld_lbl 60064 `"Eastern Africa, nec/ns"', add
label define bpld_lbl 60065 `"Eritrea"', add
label define bpld_lbl 60066 `"South Sudan"', add
label define bpld_lbl 60070 `"Central Africa"', add
label define bpld_lbl 60071 `"Angola"', add
label define bpld_lbl 60072 `"Cameroon"', add
label define bpld_lbl 60073 `"Central African Republic"', add
label define bpld_lbl 60074 `"Chad"', add
label define bpld_lbl 60075 `"Congo"', add
label define bpld_lbl 60076 `"Equatorial Guinea"', add
label define bpld_lbl 60077 `"Gabon"', add
label define bpld_lbl 60078 `"Sao Tome and Principe"', add
label define bpld_lbl 60079 `"Zaire"', add
label define bpld_lbl 60080 `"Central Africa, ns"', add
label define bpld_lbl 60081 `"Equatorial Africa, ns"', add
label define bpld_lbl 60082 `"French Equatorial Africa, ns"', add
label define bpld_lbl 60090 `"Southern Africa"', add
label define bpld_lbl 60091 `"Botswana"', add
label define bpld_lbl 60092 `"Lesotho"', add
label define bpld_lbl 60093 `"Namibia"', add
label define bpld_lbl 60094 `"South Africa (Union of)"', add
label define bpld_lbl 60095 `"Swaziland"', add
label define bpld_lbl 60096 `"Southern Africa, ns"', add
label define bpld_lbl 60099 `"Africa, ns/nec"', add
label define bpld_lbl 70000 `"Australia and New Zealand"', add
label define bpld_lbl 70010 `"Australia"', add
label define bpld_lbl 70011 `"Ashmore and Cartier Islands"', add
label define bpld_lbl 70012 `"Coral Sea Islands Territory"', add
label define bpld_lbl 70013 `"Christmas Island"', add
label define bpld_lbl 70014 `"Cocos Islands"', add
label define bpld_lbl 70020 `"New Zealand"', add
label define bpld_lbl 71000 `"Pacific Islands"', add
label define bpld_lbl 71010 `"New Caledonia"', add
label define bpld_lbl 71012 `"Papua New Guinea"', add
label define bpld_lbl 71013 `"Solomon Islands"', add
label define bpld_lbl 71014 `"Vanuatu (New Hebrides)"', add
label define bpld_lbl 71015 `"Fiji"', add
label define bpld_lbl 71016 `"Melanesia, ns"', add
label define bpld_lbl 71017 `"Norfolk Islands"', add
label define bpld_lbl 71018 `"Niue"', add
label define bpld_lbl 71020 `"Cook Islands"', add
label define bpld_lbl 71022 `"French Polynesia"', add
label define bpld_lbl 71023 `"Tonga"', add
label define bpld_lbl 71024 `"Wallis and Futuna Islands"', add
label define bpld_lbl 71025 `"Western Samoa"', add
label define bpld_lbl 71026 `"Pitcairn Island"', add
label define bpld_lbl 71027 `"Tokelau"', add
label define bpld_lbl 71028 `"Tuvalu"', add
label define bpld_lbl 71029 `"Polynesia, ns"', add
label define bpld_lbl 71032 `"Kiribati"', add
label define bpld_lbl 71033 `"Canton and Enderbury"', add
label define bpld_lbl 71034 `"Nauru"', add
label define bpld_lbl 71039 `"Micronesia, ns"', add
label define bpld_lbl 71040 `"US Pacific Trust Territories"', add
label define bpld_lbl 71041 `"Marshall Islands"', add
label define bpld_lbl 71042 `"Micronesia"', add
label define bpld_lbl 71043 `"Kosrae"', add
label define bpld_lbl 71044 `"Pohnpei"', add
label define bpld_lbl 71045 `"Truk"', add
label define bpld_lbl 71046 `"Yap"', add
label define bpld_lbl 71047 `"Northern Mariana Islands"', add
label define bpld_lbl 71048 `"Palau"', add
label define bpld_lbl 71049 `"Pacific Trust Terr, ns"', add
label define bpld_lbl 71050 `"Clipperton Island"', add
label define bpld_lbl 71090 `"Oceania, ns/nec"', add
label define bpld_lbl 80000 `"Antarctica, ns/nec"', add
label define bpld_lbl 80010 `"Bouvet Islands"', add
label define bpld_lbl 80020 `"British Antarctic Terr."', add
label define bpld_lbl 80030 `"Dronning Maud Land"', add
label define bpld_lbl 80040 `"French Southern and Antarctic Lands"', add
label define bpld_lbl 80050 `"Heard and McDonald Islands"', add
label define bpld_lbl 90000 `"Abroad (unknown) or at sea"', add
label define bpld_lbl 90010 `"Abroad, ns"', add
label define bpld_lbl 90011 `"Abroad (US citizen)"', add
label define bpld_lbl 90020 `"At sea"', add
label define bpld_lbl 90021 `"At sea (US citizen)"', add
label define bpld_lbl 90022 `"At sea or abroad (U.S. citizen)"', add
label define bpld_lbl 95000 `"Other n.e.c."', add
label define bpld_lbl 99900 `"Missing/blank"', add
label values bpld bpld_lbl

label define educ_lbl 00 `"N/A or no schooling"'
label define educ_lbl 01 `"Nursery school to grade 4"', add
label define educ_lbl 02 `"Grade 5, 6, 7, or 8"', add
label define educ_lbl 03 `"Grade 9"', add
label define educ_lbl 04 `"Grade 10"', add
label define educ_lbl 05 `"Grade 11"', add
label define educ_lbl 06 `"Grade 12"', add
label define educ_lbl 07 `"1 year of college"', add
label define educ_lbl 08 `"2 years of college"', add
label define educ_lbl 09 `"3 years of college"', add
label define educ_lbl 10 `"4 years of college"', add
label define educ_lbl 11 `"5+ years of college"', add
label values educ educ_lbl

label define educd_lbl 000 `"N/A or no schooling"'
label define educd_lbl 001 `"N/A"', add
label define educd_lbl 002 `"No schooling completed"', add
label define educd_lbl 010 `"Nursery school to grade 4"', add
label define educd_lbl 011 `"Nursery school, preschool"', add
label define educd_lbl 012 `"Kindergarten"', add
label define educd_lbl 013 `"Grade 1, 2, 3, or 4"', add
label define educd_lbl 014 `"Grade 1"', add
label define educd_lbl 015 `"Grade 2"', add
label define educd_lbl 016 `"Grade 3"', add
label define educd_lbl 017 `"Grade 4"', add
label define educd_lbl 020 `"Grade 5, 6, 7, or 8"', add
label define educd_lbl 021 `"Grade 5 or 6"', add
label define educd_lbl 022 `"Grade 5"', add
label define educd_lbl 023 `"Grade 6"', add
label define educd_lbl 024 `"Grade 7 or 8"', add
label define educd_lbl 025 `"Grade 7"', add
label define educd_lbl 026 `"Grade 8"', add
label define educd_lbl 030 `"Grade 9"', add
label define educd_lbl 040 `"Grade 10"', add
label define educd_lbl 050 `"Grade 11"', add
label define educd_lbl 060 `"Grade 12"', add
label define educd_lbl 061 `"12th grade, no diploma"', add
label define educd_lbl 062 `"High school graduate or GED"', add
label define educd_lbl 063 `"Regular high school diploma"', add
label define educd_lbl 064 `"GED or alternative credential"', add
label define educd_lbl 065 `"Some college, but less than 1 year"', add
label define educd_lbl 070 `"1 year of college"', add
label define educd_lbl 071 `"1 or more years of college credit, no degree"', add
label define educd_lbl 080 `"2 years of college"', add
label define educd_lbl 081 `"Associate's degree, type not specified"', add
label define educd_lbl 082 `"Associate's degree, occupational program"', add
label define educd_lbl 083 `"Associate's degree, academic program"', add
label define educd_lbl 090 `"3 years of college"', add
label define educd_lbl 100 `"4 years of college"', add
label define educd_lbl 101 `"Bachelor's degree"', add
label define educd_lbl 110 `"5+ years of college"', add
label define educd_lbl 111 `"6 years of college (6+ in 1960-1970)"', add
label define educd_lbl 112 `"7 years of college"', add
label define educd_lbl 113 `"8+ years of college"', add
label define educd_lbl 114 `"Master's degree"', add
label define educd_lbl 115 `"Professional degree beyond a bachelor's degree"', add
label define educd_lbl 116 `"Doctoral degree"', add
label define educd_lbl 999 `"Missing"', add
label values educd educd_lbl

label define empstat_lbl 0 `"N/A"'
label define empstat_lbl 1 `"Employed"', add
label define empstat_lbl 2 `"Unemployed"', add
label define empstat_lbl 3 `"Not in labor force"', add
label values empstat empstat_lbl

label define empstatd_lbl 00 `"N/A"'
label define empstatd_lbl 10 `"At work"', add
label define empstatd_lbl 11 `"At work, public emerg"', add
label define empstatd_lbl 12 `"Has job, not working"', add
label define empstatd_lbl 13 `"Armed forces"', add
label define empstatd_lbl 14 `"Armed forces--at work"', add
label define empstatd_lbl 15 `"Armed forces--not at work but with job"', add
label define empstatd_lbl 20 `"Unemployed"', add
label define empstatd_lbl 21 `"Unemp, exper worker"', add
label define empstatd_lbl 22 `"Unemp, new worker"', add
label define empstatd_lbl 30 `"Not in Labor Force"', add
label define empstatd_lbl 31 `"NILF, housework"', add
label define empstatd_lbl 32 `"NILF, unable to work"', add
label define empstatd_lbl 33 `"NILF, school"', add
label define empstatd_lbl 34 `"NILF, other"', add
label values empstatd empstatd_lbl

label define labforce_lbl 0 `"N/A"'
label define labforce_lbl 1 `"No, not in the labor force"', add
label define labforce_lbl 2 `"Yes, in the labor force"', add
label values labforce labforce_lbl

label define uhrswork_lbl 00 `"N/A"'
label define uhrswork_lbl 01 `"1"', add
label define uhrswork_lbl 02 `"2"', add
label define uhrswork_lbl 03 `"3"', add
label define uhrswork_lbl 04 `"4"', add
label define uhrswork_lbl 05 `"5"', add
label define uhrswork_lbl 06 `"6"', add
label define uhrswork_lbl 07 `"7"', add
label define uhrswork_lbl 08 `"8"', add
label define uhrswork_lbl 09 `"9"', add
label define uhrswork_lbl 10 `"10"', add
label define uhrswork_lbl 11 `"11"', add
label define uhrswork_lbl 12 `"12"', add
label define uhrswork_lbl 13 `"13"', add
label define uhrswork_lbl 14 `"14"', add
label define uhrswork_lbl 15 `"15"', add
label define uhrswork_lbl 16 `"16"', add
label define uhrswork_lbl 17 `"17"', add
label define uhrswork_lbl 18 `"18"', add
label define uhrswork_lbl 19 `"19"', add
label define uhrswork_lbl 20 `"20"', add
label define uhrswork_lbl 21 `"21"', add
label define uhrswork_lbl 22 `"22"', add
label define uhrswork_lbl 23 `"23"', add
label define uhrswork_lbl 24 `"24"', add
label define uhrswork_lbl 25 `"25"', add
label define uhrswork_lbl 26 `"26"', add
label define uhrswork_lbl 27 `"27"', add
label define uhrswork_lbl 28 `"28"', add
label define uhrswork_lbl 29 `"29"', add
label define uhrswork_lbl 30 `"30"', add
label define uhrswork_lbl 31 `"31"', add
label define uhrswork_lbl 32 `"32"', add
label define uhrswork_lbl 33 `"33"', add
label define uhrswork_lbl 34 `"34"', add
label define uhrswork_lbl 35 `"35"', add
label define uhrswork_lbl 36 `"36"', add
label define uhrswork_lbl 37 `"37"', add
label define uhrswork_lbl 38 `"38"', add
label define uhrswork_lbl 39 `"39"', add
label define uhrswork_lbl 40 `"40"', add
label define uhrswork_lbl 41 `"41"', add
label define uhrswork_lbl 42 `"42"', add
label define uhrswork_lbl 43 `"43"', add
label define uhrswork_lbl 44 `"44"', add
label define uhrswork_lbl 45 `"45"', add
label define uhrswork_lbl 46 `"46"', add
label define uhrswork_lbl 47 `"47"', add
label define uhrswork_lbl 48 `"48"', add
label define uhrswork_lbl 49 `"49"', add
label define uhrswork_lbl 50 `"50"', add
label define uhrswork_lbl 51 `"51"', add
label define uhrswork_lbl 52 `"52"', add
label define uhrswork_lbl 53 `"53"', add
label define uhrswork_lbl 54 `"54"', add
label define uhrswork_lbl 55 `"55"', add
label define uhrswork_lbl 56 `"56"', add
label define uhrswork_lbl 57 `"57"', add
label define uhrswork_lbl 58 `"58"', add
label define uhrswork_lbl 59 `"59"', add
label define uhrswork_lbl 60 `"60"', add
label define uhrswork_lbl 61 `"61"', add
label define uhrswork_lbl 62 `"62"', add
label define uhrswork_lbl 63 `"63"', add
label define uhrswork_lbl 64 `"64"', add
label define uhrswork_lbl 65 `"65"', add
label define uhrswork_lbl 66 `"66"', add
label define uhrswork_lbl 67 `"67"', add
label define uhrswork_lbl 68 `"68"', add
label define uhrswork_lbl 69 `"69"', add
label define uhrswork_lbl 70 `"70"', add
label define uhrswork_lbl 71 `"71"', add
label define uhrswork_lbl 72 `"72"', add
label define uhrswork_lbl 73 `"73"', add
label define uhrswork_lbl 74 `"74"', add
label define uhrswork_lbl 75 `"75"', add
label define uhrswork_lbl 76 `"76"', add
label define uhrswork_lbl 77 `"77"', add
label define uhrswork_lbl 78 `"78"', add
label define uhrswork_lbl 79 `"79"', add
label define uhrswork_lbl 80 `"80"', add
label define uhrswork_lbl 81 `"81"', add
label define uhrswork_lbl 82 `"82"', add
label define uhrswork_lbl 83 `"83"', add
label define uhrswork_lbl 84 `"84"', add
label define uhrswork_lbl 85 `"85"', add
label define uhrswork_lbl 86 `"86"', add
label define uhrswork_lbl 87 `"87"', add
label define uhrswork_lbl 88 `"88"', add
label define uhrswork_lbl 89 `"89"', add
label define uhrswork_lbl 90 `"90"', add
label define uhrswork_lbl 91 `"91"', add
label define uhrswork_lbl 92 `"92"', add
label define uhrswork_lbl 93 `"93"', add
label define uhrswork_lbl 94 `"94"', add
label define uhrswork_lbl 95 `"95"', add
label define uhrswork_lbl 96 `"96"', add
label define uhrswork_lbl 97 `"97"', add
label define uhrswork_lbl 98 `"98"', add
label define uhrswork_lbl 99 `"99 (Topcode)"', add
label values uhrswork uhrswork_lbl

compress
desc
label data "IPUMS data for the year 1980"

// confirm correct dataset
assert datanum==2

saveold "../output/IPUMS_data_1980.dta", replace

end
