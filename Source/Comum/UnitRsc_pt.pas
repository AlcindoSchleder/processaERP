unit UnitRsc_pt;

interface

uses StdConvs, ConvUtils;

resourcestring
  { ************************************************************************* }
  { Distance's family type }
  SDistanceDescription_pt = 'Distância';

  { Distance's various conversion types }
  SMicromicronsDescription_pt = 'Micromicrons';
  SAngstromsDescription_pt = 'Angstroms';
  SMillimicronsDescription_pt = 'Millimicrons';
  SMicronsDescription_pt = 'Microns';
  SMillimetersDescription_pt = 'Millímetros';
  SCentimetersDescription_pt = 'Centímetros';
  SDecimetersDescription_pt = 'Decímetros';
  SMetersDescription_pt = 'Metros';
  SDecametersDescription_pt = 'Decametros';
  SHectometersDescription_pt = 'Hectometros';
  SKilometersDescription_pt = 'Kilometros';
  SMegametersDescription_pt = 'Megametros';
  SGigametersDescription_pt = 'Gigametros';
  SInchesDescription_pt = 'Polegadas';
  SFeetDescription_pt = 'Pés';
  SYardsDescription_pt = 'Jardas';
  SMilesDescription_pt = 'Milhas';
  SNauticalMilesDescription_pt = 'Milhas Náuticas';
  SAstronomicalUnitsDescription_pt = 'Unidades Astronômicas';
  SLightYearsDescription_pt = 'Anos Luz';
  SParsecsDescription_pt = 'Parsecs';
  SCubitsDescription_pt = 'Cubits';
  SFathomsDescription_pt = 'Fathoms';
  SFurlongsDescription_pt = 'Furlongs';
  SHandsDescription_pt = 'Mãos';
  SPacesDescription_pt = 'Passos';
  SRodsDescription_pt = 'Hastes';
  SChainsDescription_pt = 'Elos';
  SLinksDescription_pt = 'Links';
  SPicasDescription_pt = 'Picas';
  SPointsDescription_pt = 'Pontos';

  { ************************************************************************* }
  { Area's family type }
  SAreaDescription_pt = 'Área';

  { Area's various conversion types }
  SSquareMillimetersDescription_pt = 'Milímetros Quadrados';
  SSquareCentimetersDescription_pt = 'Centimetros Quadrados';
  SSquareDecimetersDescription_pt = 'Decímetros Quadrados';
  SSquareMetersDescription_pt = 'Metros Quadrados';
  SSquareDecametersDescription_pt = 'Decâmetros Quadrados';
  SSquareHectometersDescription_pt = 'Hectômetros Quadrados';
  SSquareKilometersDescription_pt = 'Kilômetros Quadrados';
  SSquareInchesDescription_pt = 'Polegadas Quadradas';
  SSquareFeetDescription_pt = 'Pés Quadrados';
  SSquareYardsDescription_pt = 'Jardas Quadradas';
  SSquareMilesDescription_pt = 'Milhas Quadradas';
  SAcresDescription_pt = 'Acres';
  SCentaresDescription_pt = 'Centares';
  SAresDescription_pt = 'Ares';
  SHectaresDescription_pt = 'Hectares';
  SSquareRodsDescription_pt = 'Hastes Quadradas';

  { ************************************************************************* }
  { Volume's family type }
  SVolumeDescription_pt = 'Volume';

  { Volume's various conversion types }
  SCubicMillimetersDescription_pt = 'Milímetros Cúbicos';
  SCubicCentimetersDescription_pt = 'Centímetros Cúbicos';
  SCubicDecimetersDescription_pt = 'Decímeters Cúbicos';
  SCubicMetersDescription_pt = 'Metros Cúbicos';
  SCubicDecametersDescription_pt = 'Decâmetros Cúbicos';
  SCubicHectometersDescription_pt = 'Hectômetros Cúbicos';
  SCubicKilometersDescription_pt = 'Kilômetros Cúbicos';
  SCubicInchesDescription_pt = 'Polegadas Cúbicas';
  SCubicFeetDescription_pt = 'Pés Cúbicos';
  SCubicYardsDescription_pt = 'Jardas Cúbicas';
  SCubicMilesDescription_pt = 'Milhas Cúbicas';
  SMilliLitersDescription_pt = 'MiliLitros';
  SCentiLitersDescription_pt = 'CentiLitros';
  SDeciLitersDescription_pt = 'DeciLitros';
  SLitersDescription_pt = 'Litros';
  SDecaLitersDescription_pt = 'DecaLitros';
  SHectoLitersDescription_pt = 'HectoLitros';
  SKiloLitersDescription_pt = 'KiloLitros';
  SAcreFeetDescription_pt = 'Acre Pés';
  SAcreInchesDescription_pt = 'Acre Polegadas';
  SCordsDescription_pt = 'Cordas';
  SCordFeetDescription_pt = 'CordasPés';
  SDecisteresDescription_pt = 'Decisteres';
  SSteresDescription_pt = 'Steres';
  SDecasteresDescription_pt = 'Decasteres';

  { American Fluid Units }
  SFluidGallonsDescription_pt = 'Galões líquidos';
  SFluidQuartsDescription_pt = 'Quarto líquidos';
  SFluidPintsDescription_pt = 'Pintas líquidas';
  SFluidCupsDescription_pt = 'Copos líquidos';
  SFluidGillsDescription_pt = 'Brânquias líquidas';
  SFluidOuncesDescription_pt = 'Onças líquidas';
  SFluidTablespoonsDescription_pt = 'Colheres líquidas';
  SFluidTeaspoonsDescription_pt = 'Colheres de Chá líquidas';

  { American Dry Units }
  SDryGallonsDescription_pt = 'Galões Secos';
  SDryQuartsDescription_pt = 'Quartos Secos';
  SDryPintsDescription_pt = 'Pintas Secas';
  SDryPecksDescription_pt = 'DryPecks';
  SDryBucketsDescription_pt = 'Cubetas Secas';
  SDryBushelsDescription_pt = 'DryBushels';

  { English Imperial Fluid/Dry Units }
  SUKGallonsDescription_pt = 'UK Galões';
  SUKPottlesDescription_pt = 'UK Pote';
  SUKQuartsDescription_pt = 'UK Quartos';
  SUKPintsDescription_pt = 'UK Pintas';
  SUKGillsDescription_pt = 'UK Brânquias';
  SUKOuncesDescription_pt = 'UK Onças';
  SUKPecksDescription_pt = 'UKPecks';
  SUKBucketsDescription_pt = 'UK Cubetas';
  SUKBushelsDescription_pt = 'UKBushels';

  { ************************************************************************* }
  { Mass's family type }
  SMassDescription_pt = 'Massa';

  { Mass's various conversion types }
  SNanogramsDescription_pt = 'Nanogramas';
  SMicrogramsDescription_pt = 'Microgramas';
  SMilligramsDescription_pt = 'Miligramas';
  SCentigramsDescription_pt = 'Centigramas';
  SDecigramsDescription_pt = 'Decigramas';
  SGramsDescription_pt = 'Gramas';
  SDecagramsDescription_pt = 'Decagramas';
  SHectogramsDescription_pt = 'Hectogramas';
  SKilogramsDescription_pt = 'Kilogramas';
  SMetricTonsDescription_pt = 'Toneladas Métricas';
  SDramsDescription_pt = 'Drams';
  SGrainsDescription_pt = 'Grãos';
  STonsDescription_pt = 'Toneladas';
  SLongTonsDescription_pt = 'Toneladas Longas';
  SOuncesDescription_pt = 'Onças';
  SPoundsDescription_pt = 'Libras';
  SStonesDescription_pt = 'Pedras';

  { ************************************************************************* }
  { Temperature's family type }
  STemperatureDescription_pt = 'Temperatura';

  { Temperature's various conversion types }
  SCelsiusDescription_pt = 'Celsius';
  SKelvinDescription_pt = 'Kelvin';
  SFahrenheitDescription_pt = 'Fahrenheit';
  SRankineDescription_pt = 'Rankine';
  SReaumurDescription_pt = 'Reaumur';

  { ************************************************************************* }
  { Time's family type }
  STimeDescription_pt = 'Time';

  { Time's various conversion types }
  SMilliSecondsDescription_pt = 'MiliSegundos';
  SSecondsDescription_pt = 'Segundos';
  SMinutesDescription_pt = 'Minutos';
  SHoursDescription_pt = 'Horas';
  SDaysDescription_pt = 'Dias';
  SWeeksDescription_pt = 'Semanas';
  SFortnightsDescription_pt = 'Luas';
  SMonthsDescription_pt = 'Meses';
  SYearsDescription_pt = 'Anos';
  SDecadesDescription_pt = 'Décadas';
  SCenturiesDescription_pt = 'Séculos';
  SMillenniaDescription_pt = 'Milenios';
  SDateTimeDescription_pt = 'Data Hora';
  SJulianDateDescription_pt = 'Data Juliana';
  SModifiedJulianDateDescription_pt = 'Data Juliana Modificada';

  { simple temperature conversion }
  function FahrenheitToCelsius(const AValue: Double): Double;
  function CelsiusToFahrenheit(const AValue: Double): Double;

implementation

uses DateUtils, SysUtils;

function FahrenheitToCelsius(const AValue: Double): Double;
begin
  Result := ((AValue - 32) * 5) / 9;
end;

function CelsiusToFahrenheit(const AValue: Double): Double;
begin
  Result := ((AValue * 9) / 5) + 32;
end;

function KelvinToCelsius(const AValue: Double): Double;
begin
  Result := AValue - 273.15;
end;

function CelsiusToKelvin(const AValue: Double): Double;
begin
  Result := AValue + 273.15;
end;

function RankineToCelsius(const AValue: Double): Double;
begin
  Result := FahrenheitToCelsius(AValue - 459.67);
end;

function CelsiusToRankine(const AValue: Double): Double;
begin
  Result := CelsiusToFahrenheit(AValue) + 459.67;
end;

function ReaumurToCelsius(const AValue: Double): Double;
begin
  Result := ((CelsiusToFahrenheit(AValue) - 32) * 4) / 9;
end;

function CelsiusToReaumur(const AValue: Double): Double;
begin
  Result := FahrenheitToCelsius(((AValue * 9) / 4) + 32);
end;

function ConvDateTimeToJulianDate(const AValue: Double): Double;
begin
  Result := DateTimeToJulianDate(AValue);
end;

function ConvJulianDateToDateTime(const AValue: Double): Double;
begin
  Result := JulianDateToDateTime(AValue);
end;

function ConvDateTimeToModifiedJulianDate(const AValue: Double): Double;
begin
  Result := DateTimeToModifiedJulianDate(AValue);
end;

function ConvModifiedJulianDateToDateTime(const AValue: Double): Double;
begin
  Result := ModifiedJulianDateToDateTime(AValue);
end;

procedure InitStdConvs;
begin
  { Nothing to do, the implementation will arrange to call 'initialization' }
end;


initialization
  UnregisterConversionFamily(cbDistance);
  UnregisterConversionFamily(cbArea);
  UnregisterConversionFamily(cbVolume);
  UnregisterConversionFamily(cbMass);
  UnregisterConversionFamily(cbTemperature);
  UnregisterConversionFamily(cbTime);
  { ************************************************************************* }
  { Distance's family type }
  cbDistance := RegisterConversionFamily(SDistanceDescription_pt);

  { Distance's various conversion types }
  duMicromicrons := RegisterConversionType(cbDistance, SMicromicronsDescription_pt, 1E-12);
  duAngstroms := RegisterConversionType(cbDistance, SAngstromsDescription_pt, 1E-10);
  duMillimicrons := RegisterConversionType(cbDistance, SMillimicronsDescription_pt, 1E-9);
  duMicrons := RegisterConversionType(cbDistance, SMicronsDescription_pt, 1E-6);
  duMillimeters := RegisterConversionType(cbDistance, SMillimetersDescription_pt, 0.001);
  duCentimeters := RegisterConversionType(cbDistance, SCentimetersDescription_pt, 0.01);
  duDecimeters := RegisterConversionType(cbDistance, SDecimetersDescription_pt, 0.1);
  duMeters := RegisterConversionType(cbDistance, SMetersDescription_pt, 1);
  duDecameters := RegisterConversionType(cbDistance, SDecametersDescription_pt, 10);
  duHectometers := RegisterConversionType(cbDistance, SHectometersDescription_pt, 100);
  duKilometers := RegisterConversionType(cbDistance, SKilometersDescription_pt, 1000);
  duMegameters := RegisterConversionType(cbDistance, SMegametersDescription_pt, 1E+6);
  duGigameters := RegisterConversionType(cbDistance, SGigametersDescription_pt, 1E+9);
  duInches := RegisterConversionType(cbDistance, SInchesDescription_pt, MetersPerInch);
  duFeet := RegisterConversionType(cbDistance, SFeetDescription_pt, MetersPerFoot);
  duYards := RegisterConversionType(cbDistance, SYardsDescription_pt, MetersPerYard);
  duMiles := RegisterConversionType(cbDistance, SMilesDescription_pt, MetersPerMile);
  duNauticalMiles := RegisterConversionType(cbDistance, SNauticalMilesDescription_pt, MetersPerNauticalMiles);
  duAstronomicalUnits := RegisterConversionType(cbDistance, SAstronomicalUnitsDescription_pt, MetersPerAstronomicalUnit);
  duLightYears := RegisterConversionType(cbDistance, SLightYearsDescription_pt, MetersPerLightYear);
  duParsecs := RegisterConversionType(cbDistance, SParsecsDescription_pt, MetersPerParsec);
  duCubits := RegisterConversionType(cbDistance, SCubitsDescription_pt, MetersPerCubit);
  duFathoms := RegisterConversionType(cbDistance, SFathomsDescription_pt, MetersPerFathom);
  duFurlongs := RegisterConversionType(cbDistance, SFurlongsDescription_pt, MetersPerFurlong);
  duHands := RegisterConversionType(cbDistance, SHandsDescription_pt, MetersPerHand);
  duPaces := RegisterConversionType(cbDistance, SPacesDescription_pt, MetersPerPace);
  duRods := RegisterConversionType(cbDistance, SRodsDescription_pt, MetersPerRod);
  duChains := RegisterConversionType(cbDistance, SChainsDescription_pt, MetersPerChain);
  duLinks := RegisterConversionType(cbDistance, SLinksDescription_pt, MetersPerLink);
  duPicas := RegisterConversionType(cbDistance, SPicasDescription_pt, MetersPerPica);
  duPoints := RegisterConversionType(cbDistance, SPointsDescription_pt, MetersPerPoint);

  { ************************************************************************* }
  { Area's family type }
  cbArea := RegisterConversionFamily(SAreaDescription_pt);

  { Area's various conversion types }
  auSquareMillimeters := RegisterConversionType(cbArea, SSquareMillimetersDescription_pt, 1E-6);
  auSquareCentimeters := RegisterConversionType(cbArea, SSquareCentimetersDescription_pt, 0.0001);
  auSquareDecimeters := RegisterConversionType(cbArea, SSquareDecimetersDescription_pt, 0.01);
  auSquareMeters := RegisterConversionType(cbArea, SSquareMetersDescription_pt, 1);
  auSquareDecameters := RegisterConversionType(cbArea, SSquareDecametersDescription_pt, 100);
  auSquareHectometers := RegisterConversionType(cbArea, SSquareHectometersDescription_pt, 10000);
  auSquareKilometers := RegisterConversionType(cbArea, SSquareKilometersDescription_pt, 1E+6);
  auSquareInches := RegisterConversionType(cbArea, SSquareInchesDescription_pt, SquareMetersPerSquareInch);
  auSquareFeet := RegisterConversionType(cbArea, SSquareFeetDescription_pt, SquareMetersPerSquareFoot);
  auSquareYards := RegisterConversionType(cbArea, SSquareYardsDescription_pt, SquareMetersPerSquareYard);
  auSquareMiles := RegisterConversionType(cbArea, SSquareMilesDescription_pt, SquareMetersPerSquareMile);
  auAcres := RegisterConversionType(cbArea, SAcresDescription_pt, SquareMetersPerAcre);
  auCentares := RegisterConversionType(cbArea, SCentaresDescription_pt, 1);
  auAres := RegisterConversionType(cbArea, SAresDescription_pt, 100);
  auHectares := RegisterConversionType(cbArea, SHectaresDescription_pt, 10000);
  auSquareRods := RegisterConversionType(cbArea, SSquareRodsDescription_pt, SquareMetersPerSquareRod);

  { ************************************************************************* }
  { Volume's family type }
  cbVolume := RegisterConversionFamily(SVolumeDescription_pt);

  { Volume's various conversion types }
  vuCubicMillimeters := RegisterConversionType(cbVolume, SCubicMillimetersDescription_pt, 1E-9);
  vuCubicCentimeters := RegisterConversionType(cbVolume, SCubicCentimetersDescription_pt, 1E-6);
  vuCubicDecimeters := RegisterConversionType(cbVolume, SCubicDecimetersDescription_pt, 0.001);
  vuCubicMeters := RegisterConversionType(cbVolume, SCubicMetersDescription_pt, 1);
  vuCubicDecameters := RegisterConversionType(cbVolume, SCubicDecametersDescription_pt, 1000);
  vuCubicHectometers := RegisterConversionType(cbVolume, SCubicHectometersDescription_pt, 1E+6);
  vuCubicKilometers := RegisterConversionType(cbVolume, SCubicKilometersDescription_pt, 1E+9);
  vuCubicInches := RegisterConversionType(cbVolume, SCubicInchesDescription_pt, CubicMetersPerCubicInch);
  vuCubicFeet := RegisterConversionType(cbVolume, SCubicFeetDescription_pt, CubicMetersPerCubicFoot);
  vuCubicYards := RegisterConversionType(cbVolume, SCubicYardsDescription_pt, CubicMetersPerCubicYard);
  vuCubicMiles := RegisterConversionType(cbVolume, SCubicMilesDescription_pt, CubicMetersPerCubicMile);
  vuMilliLiters := RegisterConversionType(cbVolume, SMilliLitersDescription_pt, 1E-6);
  vuCentiLiters := RegisterConversionType(cbVolume, SCentiLitersDescription_pt, 1E-5);
  vuDeciLiters := RegisterConversionType(cbVolume, SDeciLitersDescription_pt, 1E-4);
  vuLiters := RegisterConversionType(cbVolume, SLitersDescription_pt, 0.001);
  vuDecaLiters := RegisterConversionType(cbVolume, SDecaLitersDescription_pt, 0.01);
  vuHectoLiters := RegisterConversionType(cbVolume, SHectoLitersDescription_pt, 0.1);
  vuKiloLiters := RegisterConversionType(cbVolume, SKiloLitersDescription_pt, 1);
  vuAcreFeet := RegisterConversionType(cbVolume, SAcreFeetDescription_pt, CubicMetersPerAcreFoot);
  vuAcreInches := RegisterConversionType(cbVolume, SAcreInchesDescription_pt, CubicMetersPerAcreInch);
  vuCords := RegisterConversionType(cbVolume, SCordsDescription_pt, CubicMetersPerCord);
  vuCordFeet := RegisterConversionType(cbVolume, SCordFeetDescription_pt, CubicMetersPerCordFoot);
  vuDecisteres := RegisterConversionType(cbVolume, SDecisteresDescription_pt, 0.1);
  vuSteres := RegisterConversionType(cbVolume, SSteresDescription_pt, 1);
  vuDecasteres := RegisterConversionType(cbVolume, SDecasteresDescription_pt, 10);

  { American Fluid Units }
  vuFluidGallons := RegisterConversionType(cbVolume, SFluidGallonsDescription_pt, CubicMetersPerUSFluidGallon);
  vuFluidQuarts := RegisterConversionType(cbVolume, SFluidQuartsDescription_pt, CubicMetersPerUSFluidQuart);
  vuFluidPints := RegisterConversionType(cbVolume, SFluidPintsDescription_pt, CubicMetersPerUSFluidPint);
  vuFluidCups := RegisterConversionType(cbVolume, SFluidCupsDescription_pt, CubicMetersPerUSFluidCup);
  vuFluidGills := RegisterConversionType(cbVolume, SFluidGillsDescription_pt, CubicMetersPerUSFluidGill);
  vuFluidOunces := RegisterConversionType(cbVolume, SFluidOuncesDescription_pt, CubicMetersPerUSFluidOunce);
  vuFluidTablespoons := RegisterConversionType(cbVolume, SFluidTablespoonsDescription_pt, CubicMetersPerUSFluidTablespoon);
  vuFluidTeaspoons := RegisterConversionType(cbVolume, SFluidTeaspoonsDescription_pt, CubicMetersPerUSFluidTeaspoon);

  { American Dry Units }
  vuDryGallons := RegisterConversionType(cbVolume, SDryGallonsDescription_pt, CubicMetersPerUSDryGallon);
  vuDryQuarts := RegisterConversionType(cbVolume, SDryQuartsDescription_pt, CubicMetersPerUSDryQuart);
  vuDryPints := RegisterConversionType(cbVolume, SDryPintsDescription_pt, CubicMetersPerUSDryPint);
  vuDryPecks := RegisterConversionType(cbVolume, SDryPecksDescription_pt, CubicMetersPerUSDryPeck);
  vuDryBuckets := RegisterConversionType(cbVolume, SDryBucketsDescription_pt, CubicMetersPerUSDryBucket);
  vuDryBushels := RegisterConversionType(cbVolume, SDryBushelsDescription_pt, CubicMetersPerUSDryBushel);

  { English Imperial Fluid/Dry Units }
  vuUKGallons := RegisterConversionType(cbVolume, SUKGallonsDescription_pt, CubicMetersPerUKGallon);
  vuUKPottles := RegisterConversionType(cbVolume, SUKPottlesDescription_pt, CubicMetersPerUKPottle);
  vuUKQuarts := RegisterConversionType(cbVolume, SUKQuartsDescription_pt, CubicMetersPerUKQuart);
  vuUKPints := RegisterConversionType(cbVolume, SUKPintsDescription_pt, CubicMetersPerUKPint);
  vuUKGills := RegisterConversionType(cbVolume, SUKGillsDescription_pt, CubicMetersPerUKGill);
  vuUKOunces := RegisterConversionType(cbVolume, SUKOuncesDescription_pt, CubicMetersPerUKOunce);
  vuUKPecks := RegisterConversionType(cbVolume, SUKPecksDescription_pt, CubicMetersPerUKPeck);
  vuUKBuckets := RegisterConversionType(cbVolume, SUKBucketsDescription_pt, CubicMetersPerUKBucket);
  vuUKBushels := RegisterConversionType(cbVolume, SUKBushelsDescription_pt, CubicMetersPerUKBushel);

  { ************************************************************************* }
  { Mass's family type }
  cbMass := RegisterConversionFamily(SMassDescription_pt);

  { Mass's various conversion types }
  muNanograms := RegisterConversionType(cbMass, SNanogramsDescription_pt, 1E-9);
  muMicrograms := RegisterConversionType(cbMass, SMicrogramsDescription_pt, 1E-6);
  muMilligrams := RegisterConversionType(cbMass, SMilligramsDescription_pt, 0.001);
  muCentigrams := RegisterConversionType(cbMass, SCentigramsDescription_pt, 0.01);
  muDecigrams := RegisterConversionType(cbMass, SDecigramsDescription_pt, 0.1);
  muGrams := RegisterConversionType(cbMass, SGramsDescription_pt, 1);
  muDecagrams := RegisterConversionType(cbMass, SDecagramsDescription_pt, 10);
  muHectograms := RegisterConversionType(cbMass, SHectogramsDescription_pt, 100);
  muKilograms := RegisterConversionType(cbMass, SKilogramsDescription_pt, 1000);
  muMetricTons := RegisterConversionType(cbMass, SMetricTonsDescription_pt, 1E+6);
  muDrams := RegisterConversionType(cbMass, SDramsDescription_pt, GramsPerDrams);
  muGrains := RegisterConversionType(cbMass, SGrainsDescription_pt, GramsPerGrains);
  muTons := RegisterConversionType(cbMass, STonsDescription_pt, GramsPerTons);
  muLongTons := RegisterConversionType(cbMass, SLongTonsDescription_pt, GramsPerLongTons);
  muOunces := RegisterConversionType(cbMass, SOuncesDescription_pt, GramsPerOunces);
  muPounds := RegisterConversionType(cbMass, SPoundsDescription_pt, GramsPerPound);
  muStones := RegisterConversionType(cbMass, SStonesDescription_pt, GramsPerStones);

  { ************************************************************************* }
  { Temperature's family type }
  cbTemperature := RegisterConversionFamily(STemperatureDescription_pt);

  { Temperature's various conversion types }
  tuCelsius := RegisterConversionType(cbTemperature, SCelsiusDescription_pt, 1);
  tuKelvin := RegisterConversionType(cbTemperature, SKelvinDescription_pt,
    KelvinToCelsius, CelsiusToKelvin);
  tuFahrenheit := RegisterConversionType(cbTemperature, SFahrenheitDescription_pt,
    FahrenheitToCelsius, CelsiusToFahrenheit);
  tuRankine := RegisterConversionType(cbTemperature, SRankineDescription_pt,
    RankineToCelsius, CelsiusToRankine);
  tuReaumur := RegisterConversionType(cbTemperature, SReaumurDescription_pt,
    ReaumurToCelsius, CelsiusToReaumur);

  { ************************************************************************* }
  { Time's family type }
  cbTime := RegisterConversionFamily(STimeDescription_pt);

  { Time's various conversion types }
  tuMilliSeconds := RegisterConversionType(cbTime, SMilliSecondsDescription_pt, 1 / MSecsPerDay);
  tuSeconds := RegisterConversionType(cbTime, SSecondsDescription_pt, 1 / SecsPerDay);
  tuMinutes := RegisterConversionType(cbTime, SMinutesDescription_pt, 1 / MinsPerDay);
  tuHours := RegisterConversionType(cbTime, SHoursDescription_pt, 1 / HoursPerDay);
  tuDays := RegisterConversionType(cbTime, SDaysDescription_pt, 1);
  tuWeeks := RegisterConversionType(cbTime, SWeeksDescription_pt, DaysPerWeek);
  tuFortnights := RegisterConversionType(cbTime, SFortnightsDescription_pt, WeeksPerFortnight * DaysPerWeek);
  tuMonths := RegisterConversionType(cbTime, SMonthsDescription_pt, ApproxDaysPerMonth);
  tuYears := RegisterConversionType(cbTime, SYearsDescription_pt, ApproxDaysPerYear);
  tuDecades := RegisterConversionType(cbTime, SDecadesDescription_pt, ApproxDaysPerYear * YearsPerDecade);
  tuCenturies := RegisterConversionType(cbTime, SCenturiesDescription_pt, ApproxDaysPerYear * YearsPerCentury);
  tuMillennia := RegisterConversionType(cbTime, SMillenniaDescription_pt, ApproxDaysPerYear * YearsPerMillennium);
  tuDateTime := RegisterConversionType(cbTime, SDateTimeDescription_pt, 1);
  tuJulianDate := RegisterConversionType(cbTime, SJulianDateDescription_pt,
    ConvJulianDateToDateTime, ConvDateTimeToJulianDate);
  tuModifiedJulianDate := RegisterConversionType(cbTime, SModifiedJulianDateDescription_pt,
    ConvModifiedJulianDateToDateTime, ConvDateTimeToModifiedJulianDate);

finalization

  { Unregister all the conversion types we are responsible for }
  UnregisterConversionFamily(cbDistance);
  UnregisterConversionFamily(cbArea);
  UnregisterConversionFamily(cbVolume);
  UnregisterConversionFamily(cbMass);
  UnregisterConversionFamily(cbTemperature);
  UnregisterConversionFamily(cbTime);

end.
