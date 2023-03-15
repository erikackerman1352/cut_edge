function H = contract(H, t)

ns = neighbors(H, t);
T = H;


for n = 1:length(ns)
    ns_2 = neighbors(T, ns(n));
    for k = 1:length(ns_2)
        eidx = findedge(T, ns_2(k), ns(n));
        
%         newedge = table([ns_2(k) ,t], cellstr(num2str(eidx(1))), 'VariableNames', {'EndNodes','Name'});
        for i = 1:length(eidx)
        newedge = table([ns_2(k) ,t], T.Edges.Name(eidx(i)), 'VariableNames', {'EndNodes','Name'});
        T = addedge(T, newedge);
        end
    end
    
end  

% name = [];
% for i  = 1 :length(ns)
%     n = cell2mat(T.Nodes.Name(ns(i)));
%     name = cat(1, name', n);
% end
for i = 1:length(ns)
    index = find(strcmp(T.Nodes.Name, string(H.Nodes.Name(ns(i)))));
    T = rmnode(T, index);
    if isempty(index)
        T = rmnode(T, ns(i));
    end
end



index = find(strcmp(T.Nodes.Name, H.Nodes.Name(t)));
T = rmedge(T, index, index );

H = T;
end