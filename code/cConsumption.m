function c=cConsumption(d,const)
%
%    c=cConsumption(d,const)
%
%    Consumption for cistern balance
%    d: day of the year (from 1 to 366)
%    const: model parameters.
%
%    one of the parameters in const.opt is consumption_rule; 
%    this governs which consumption rule is used
%    see declarations.m for documentation of these rules

if(const.opt.consumption_rule==0) %Standard Rule: bimodal consumption
     if(d>const.dry_period(1) && d<const.dry_period(2)) %dry season
          c=const.cons_year/(const.dry_period(2)-const.dry_period(1)+1);
     else
          c=0; % rainy season
     end
     
elseif(const.opt.consumption_rule==1) % Alternate Consumption Rule 1
     if(d>const.dry_period(1) && d<const.dry_period(2)) %dry season
          c=const.cons_year/(const.dry_period(2)-const.dry_period(1)+1);
     else
          c=const.cons_rainy; %rainy season consumption defined in const
     end
elseif(const.opt.consumption_rule==2)
     c=const.cons_yearround;
else
     error('Consumption rule not defined')
end

end