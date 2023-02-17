function response_data = data_from_tables(excel_file, Ids, data_column_idx)

[~, sheets] = xlsfinfo(excel_file);

response_data = cell(length(Ids),1);

for i = 1: length(Ids)
    data_temp = xlsread(excel_file,i);
    IDs_involved = Ids{i};
    sub_data = data_temp(ismember(data_temp(:,1), IDs_involved),[1,data_column_idx]);
    sub_data_temp = zeros(size(sub_data));
    data_added = 0;
    for j = 1:length(IDs_involved)
        %disp(sub_data(j,1));
        %disp(IDs_involved(j));
        
        [index, found] = find(sub_data(:,1) == IDs_involved(j));
        if found 
            data_added = data_added+1;
            sub_data_temp(data_added,:) = sub_data(index,:);
        end
    end
    response_data{i} = sub_data_temp;
    
end

