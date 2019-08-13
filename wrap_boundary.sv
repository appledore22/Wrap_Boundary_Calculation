module wrap_boundary;
    
    initial begin
        int start_addr = 32'h44;
        byte byte_size = 8'd4;
        byte no_of_transfers = 8'd4;

        int memory[real];
        real index,temp;
        int wrap_boundary;
        int total_bytes;
        bit aligned;        

        aligned = ((start_addr)%byte_size == 1'b0) ? 1'b1 : 0'b0;
        total_bytes = byte_size*no_of_transfers;
        temp = start_addr;

        $display("\n\tSTART ADDRESS\t: 0x%0h",start_addr);
        $display("\n\tBYTES/TRANSFER\t: 0x%0h",byte_size);
        $display("\n\tNO_OF_TRANSFERS\t: 0x%0h",no_of_transfers);


        if(aligned)
        begin                    
            wrap_boundary = ($ceil(real'(start_addr)/total_bytes))*(total_bytes);
            
            $display("\n\tWRAP BONDARY\t: 0x%0h",wrap_boundary);

            for (int i = 1; i<=no_of_transfers;i++)
            begin
                //$display("Address = %0h",start_addr);

                if(start_addr == wrap_boundary)
                begin
                    start_addr = temp + ((i-1)*(byte_size)) - total_bytes;
                    //$display("Address = %0h",start_addr);  
                end

                memory[start_addr] = i;
                //$display("Address = %0h",start_addr);                
                start_addr = start_addr + (byte_size);

            end
           
            foreach(memory[i])
            begin
                $display("\n\t Address :   0x%0h \t Value :    %0d",i,memory[i]);                
            end
        end
        else
        begin
            $display("\n\t  Start Addr not aligned");
        end
        
    end
    

endmodule