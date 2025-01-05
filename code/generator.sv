class generator;
    transaction tx;
    mailbox gen2drv;
    logic[4:0] w_addr;

    function new(mailbox gen2drv);
        this.gen2drv = gen2drv;
    endfunction //new()
    task write();
        repeat(1) begin
            tx=new();
            tx.randomize();
            tx.wr=1;
            tx.rd=0;
            w_addr=tx.w_addr;
            gen2drv.put(tx);
            tx.display("GENERATOR writing");
        end
    endtask //write
    task read();
        repeat(1) begin
            tx=new();
            tx.randomize();
            tx.wr=0;
            tx.rd=1;
            tx.r_addr=w_addr;
            gen2drv.put(tx);
            tx.display("GENERATOR reading");
        end
    endtask //read
    task read_write();
        repeat(1) begin
            tx=new();
            tx.randomize();
            tx.wr=1;
            tx.rd=0;
            w_addr=tx.w_addr;
            gen2drv.put(tx);
            tx.display("GENERATOR reading_writing wr");
        end
        #10 repeat(1) begin
            tx.wr=0;
            tx.rd=1;
            tx.r_addr=w_addr;
            gen2drv.put(tx);
            tx.display("GENERATOR reading_writing rd");
        end
    endtask //read
endclass //generator