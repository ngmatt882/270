module AddSub4Co(a,b,co,r,ovf);
    input [3:0] a,b;
    input co;
    output [3:0] r;
    output ovf;
    wire [3:0] cb;
    wire cout1, cout2, cout3, cout4;
    
    assign cb = co ? ~b : b;
    
    FA f1(a[0],cb[0],co,cout1,r[0]);
    FA f2(a[1],cb[1],cout1,cout2,r[1]);
    FA f3(a[2],cb[2],cout2,cout3,r[2]);
    FA f4(a[3],cb[3],cout3,cout4,r[3]);
    
    assign ovf = cout3 ^ cout4;
endmodule