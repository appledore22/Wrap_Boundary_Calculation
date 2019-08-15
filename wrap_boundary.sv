module wrap_boundary;
    
    initial begin
        int start_addr = 32'h38;
        byte byte_size = 8'd4;
        byte no_of_transfers = 8'd4;

        // Define memory as associative array to store data into different memory location
        int memory[real];
        real index;
        int wrap_boundary,temp_addr;
        int total_bytes;
        bit aligned;        

        aligned = ((start_addr)%byte_size == 1'b0) ? 1'b1 : 0'b0;
        total_bytes = byte_size*no_of_transfers;

        $display("\n\tSTART ADDRESS\t: 0x%0h",start_addr);
        $display("\n\tBYTES/TRANSFER\t: %0d",byte_size);
        $display("\n\tNO_OF_TRANSFERS\t: %0d",no_of_transfers);


        if(aligned)
        begin 
            // If we divide an interger with a non-real number than the result will quantize as follows -
            // 56/16 = 3.5 = 3
            // If we convert the integer into real and then use $ceil the result obtained will be 56/16 = 3.5 = $ceil(3.5) = 4                    
            wrap_boundary = ($ceil(real'(start_addr)/total_bytes))*(total_bytes);

            //Calculation of new addr after wrapping boundary is reached
            temp_addr = int'(((start_addr)/total_bytes)*(total_bytes));

            
            $display("\n\tWRAP BONDARY\t: 0x%0h",wrap_boundary);

            for (int i = 1; i<=no_of_transfers;i++)
            begin

                if(start_addr == wrap_boundary)
                begin
                    start_addr = temp_addr;  
                end

                memory[start_addr] = i;               
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