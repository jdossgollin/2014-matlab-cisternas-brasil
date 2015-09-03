function const = declarations()
%    const = declarations()
%
%    Stores and records variable declarations and configuration
%    options. Includes documentation for each variable to record meaning.
%    const contains the constants needed for the function
%    Creates sub-structure .opt with configurable options to be called by
%    certain functions

%% Model Parameters

const.runoff = 0.85; %runoff coefficient, in dminesionless units
% see model parameters section
const.ffdisc = 2; %first-flush discard, in mm
% see model parameters subsection
const.vcmax = 16000; %cistern volume, in liters
% see model parameters subsection
const.dry_period = [150,365]; %start and finish days of dry season
const.latlim=[-17.93,-2.76]; %include only meteorological posts falling
% within this range (latitude)
const.lonlim=[-46.39,-34.50]; %as above (longitude)
const.data_begin=1950; %first year of downloaded data
const.data_end=2013; %last year of downloaded data
const.starting_volume=0.5*const.vcmax; %cisterns start half-full

%% Configurable options:

% Map Configuration
const.opt.dot_size=25; %dot size on maps
const.opt.mintick=0.5; %minimum value for map colorbar
const.opt.hist_bins=20; %number of bins for histogram
const.opt.figure_toggle=0; %determines which figures produced:
%    0 for no figures
%    1 to draw maps
const.opt.map_mar=0; %margin around maps (in degrees)
const.opt.mapcolor=1;
%    1 for color
%    0 for black_white

% Data Analysis and Sourcing
const.opt.nerrok = 7; %number of missing data values permitted in a year
% of data before the year's data is discarded
% see data used subsection
const.opt.minyrs = 15; %number of years with usable data required for a
% meteorological post to be considered
% see data used subsection
const.opt.roof_source = 1; %option for sourcing roof data
%         1 for 'default.txt'
%         2 for 'Milha.txt'
%         3 for 'paper2009.txt'
%         4 for command window specification of filename
%             write filename as string; file must be readable using load()
%              include the full path if needed

% Configurable Consumption Rules
const.opt.consumption_rule=0; %rule for consumption pattern
%     0 is the default assumption: all water is consumed during the
%         dry period
%     1 is the secondary option: the same quantity of water is
%         consumed evenly all year long
%     2 is the third option: there are two separate nonzero rules for
%         water consumption during rainy and dry seasONS
% NOTE: the following consumption amounts are not in the .opt substructure
% (they are directly in const) but they are grouped here for clarity
const.cons_year=16000; %yearly consumption, in liters -- does not need
% to change for changing consumption_rule
const.cons_rainy=0.25*const.cons_year; %rainy season consumption for use
% with const.opt.consumption_rule=1
const.cons_yearround=5*3; %constant year-long consumption for use with
% const.opt.consumption_rule=2; multiplied by 5 to assume 5 ppl/family

% Data
const.data_path = '../data'
end
