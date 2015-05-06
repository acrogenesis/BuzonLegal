# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

states = [
  { name: 'BajaCaliforniaNorte', online: true, last_time_online: Date.today },
  { name: 'BajaCaliforniaSur', online: true, last_time_online: Date.today }
]

bcn_tribunals = [
  'H. TRIBUNAL SUPERIOR DE JUSTICIA DEL ESTADO DE BAJA CALIFORNIA',
  'JUZGADO PRIMERO CIVIL MEXICALI',
  'JUZGADO SEGUNDO CIVIL MEXICALI',
  'JUZGADO TERCERO CIVIL MEXICALI',
  'JUZGADO CUARTO CIVIL MEXICALI',
  'JUZGADO QUINTO CIVIL MEXICALI',
  'JUZGADO SEXTO CIVIL MEXICALI',
  'JUZGADO PRIMERO DE LO FAMILIAR MEXICALI',
  'JUZGADO SEGUNDO DE LO FAMILIAR MEXICALI',
  'JUZGADO TERCERO DE LO FAMILIAR MEXICALI',
  'JUZGADO PRIMERO DE PAZ CIVIL, MEXICALI',
  'JUZGADO SEGUNDO DE PAZ CIVIL, MEXICALI',
  'JUZGADO PRIMERO CIVIL TIJUANA',
  'JUZGADO SEGUNDO CIVIL TIJUANA',
  'JUZGADO TERCERO CIVIL TIJUANA',
  'JUZGADO CUARTO CIVIL TIJUANA',
  'JUZGADO QUINTO CIVIL TIJUANA',
  'JUZGADO SEXTO CIVIL TIJUANA',
  'JUZGADO SEPTIMO CIVIL TIJUANA',
  'JUZGADO OCTAVO CIVIL TIJUANA',
  'JUZGADO NOVENO CIVIL TIJUANA',
  'JUZGADO DECIMO CIVIL TIJUANA',
  'JUZGADO DECIMO PRIMERO CIVIL TIJUANA',
  'JUZGADO PRIMERO DE LO FAMILIAR TIJUANA',
  'JUZGADO SEGUNDO DE LO FAMILIAR TIJUANA',
  'JUZGADO TERCERO DE LO FAMILIAR TIJUANA',
  'JUZGADO PRIMERO CIVIL ENSENADA',
  'JUZGADO SEGUNDO CIVIL ENSENADA',
  'JUZGADO TERCERO CIVIL ENSENADA',
  'JUZGADO PRIMERO DE LO FAMILIAR ENSENADA',
  'JUZGADO SEGUNDO DE LO FAMILIAR ENSENADA',
  'MIXTO DE PAZ ENSENADA',
  'JUZGADO DE PRIMERA INSTANCIA CIVIL, SAN QUINTÍN',
  'JUZGADO DE PRIMERA INSTANCIA CIVIL, PLAYAS DE ROSARITO',
  'JUZGADO DE 1ERA INST.CIVIL TECATE',
  'JUZGADO MIXTO DE PRIMERA INSTANCIA, SAN FELIPE',
  'JUZGADO DE PRIMERA INSTANCIA DE LO CIVIL, CIUDAD GUADALUPE VICTORIA',
  'JUZGADO MIXTO DE PRIMERA INSTANCIA, CIUDAD MORELOS'
]

bcs_tribunals = [
  'Primera Sala Civil, Salas Unitarias (vigentes)',
  'Segunda Sala Civil, Salas Unitarias (vigentes)',
  'Primera Sala Penal, Salas Unitarias (vigentes)',
  'Segunda Sala Penal, Salas Unitarias (vigentes)',
  'Sala Administrativa, Salas Unitarias (vigentes)',
  'Sala Justicia Para Adolescentes, Salas Unitarias (vigentes)',
  'Primera Sala Ramo Civil, Salas Mixtas',
  'Primera Sala Ramo Penal, Salas Mixtas',
  'Segunda Sala Ramo Civil, Salas Mixtas',
  'Segunda Sala Ramo Penal, Salas Mixtas',
  'Sala Civil y Administrativa, Salas Mixtas',
  'I Civil y Familiar Cabo San Lucas, Los Cabos',
  'II Civil y Familiar Cabo San Lucas, Los Cabos',
  'Penal Cabo San Lucas, Los Cabos',
  'I Civil y Familiar San Jose del Cabo, Los Cabos',
  'II Civil y Familiar San Jose del Cabo, Los Cabos',
  'I Penal San Jose del Cabo, Los Cabos',
  'II Penal San Jose del Cabo, Los Cabos',
  'Central de Consignaciones de Pensiones Alimentarias, Los Cabos',
  'Primero Civil, La Paz',
  'Segundo Civil, La Paz',
  'Primero Mercantil, La Paz',
  'Segundo Mercantil, La Paz',
  'Tercero Mercantil, La Paz',
  'Primero Familiar, La Paz',
  'Segundo Familiar, La Paz',
  'Tercero Familiar, La Paz',
  'Para Adolescentes, La Paz',
  'Central de Consignaciones de Pensiones Alimentarias, La Paz',
  'Primero Penal, La Paz',
  'Segundo Penal, La Paz',
  'Tercero Penal, La Paz',
  'Ejecucíon de Sanciones y Medidas de Seguridad, La Paz',
  'Primero Mixto Cd. Contitucion Ramo Civil, Comondú',
  'Primero Mixto Cd. Contitucion Ramo Penal, Comondú',
  'Segundo Mixto Cd. Contitucion Ramo Civil, Comondú',
  'Segundo Mixto Cd. Contitucion Ramo Penal, Comondú',
  'Mixto Loreto Ramo Civil, Loreto',
  'Mixto Loreto Ramo Penal, Loreto',
  'Mixto Santa Rosalia Ramo Civil, Mulegé',
  'Mixto Santa Rosalia Ramo Penal, Mulegé',
  'Mixto Guerrero Negro Ramo Civil, Mulegé',
  'Mixto Guerrero Negro Ramo Penal, Mulegé'
]

acuerdos_dev = [
  { date: Date.new(2015, 05, 04), casenumber: '0042/2015', description: 'HSBC MEXICO,S.A., INSTITUCION DE BANCA MULTIPLE, GRUPO FINANCIERO HSBC DIVISION, FIDUCIARIA VS. ROGELIO VERDUZCO GARCIA. ESPECIAL HIPOTECARIO.DOS ACDOS.', tribunal_id: 1},
  { date: Date.new(2015, 05, 04), casenumber: '0513/201', description: 'ROBERTO ESCOBAR BRAMBILA VS. ROBERTO DAVID RENDON ALVA. EJECUTIVO MERCANTIL. INICIO.TRES ACDOS.', tribunal_id: 1}
]

states.each do |state|
  State.create do |s|
    s.name = state[:name]
    s.online = state[:online]
    s.last_time_online = state[:last_time_online]
  end
end

baja_california_norte = State.find_by name: 'BajaCaliforniaNorte'
bcn_tribunals.each do |tribunal|
  baja_california_norte.tribunals.create do |t|
    t.name = tribunal
  end
end

baja_california_sur = State.find_by name: 'BajaCaliforniaSur'
bcs_tribunals.each do |tribunal|
  baja_california_sur.tribunals.create do |t|
    t.name = tribunal
  end
end

htribunal = Tribunal.where 'name ILIKE ?',  'H. TRIBUNAL%'
acuerdos_dev.each do |acuerdo|
  htribunal[0].cases.create do |c|
    c.casenumber = acuerdo[:casenumber]
    c.date = acuerdo[:date]
    c.description = acuerdo[:description]
  end
end
