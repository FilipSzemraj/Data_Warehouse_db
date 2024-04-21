set working_directory=%~dp0
set control_file=%working_directory%
set DB_USERNAME=c##Filip
set DB_PASSWORD=test
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\kolor.ctl LOG = 'LOGS/Kolor.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\marka.ctl LOG= 'LOGS/Marka.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\wojewodztwo.ctl LOG= 'LOGS/Wojewodztwo.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\miasto.ctl LOG= 'LOGS/Miasto.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\model.ctl LOG= 'LOGS/Model.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\stanowisko.ctl LOG= 'LOGS/Stanowisko.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\ulica.ctl LOG= 'LOGS/Ulica.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\klient.ctl LOG= 'LOGS/Klient.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\salon.ctl LOG= 'LOGS/Salon.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\pracownik.ctl LOG= 'LOGS/Pracownik.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\telefony.ctl LOG= 'LOGS/Telefony.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\magazyn.ctl LOG= 'LOGS/Magazyn.log'
sqlldr %DB_USERNAME%/%DB_PASSWORD% control = %control_file%CTL\umowa.ctl LOG= 'LOGS/Umowa.log'




