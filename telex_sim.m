function g = telex_sim(prob)

g = Game(prob);

% last_side = -1;             % start building tree on the left

for iWeek = 1:12
  disp(['*********** Week: ' num2str(iWeek) ' ************* ']);
  g.recruit(iWeek);
%   g.collect;
%   g.sell;
end

disp(['Total Recruits ' num2str(g.i)]);


end

% function [side, last_side] = find_side(last_side)
%         last_side = -1*last_side;
%         side = last_side;
% end

