public virtual class Platypus extends Animal {
    //class level variable
    private static Integer instanceCounter = 0;
    //instance variable
    public String moveReturn = 'fly';
    
    //instance method
    public override String move(){
        
        //local variable
        String prefix = 'super-';
        
        System.debug('Parent Sound' + super.move());
        return prefix + moveReturn;
    }
    
    public Platypus(){
        Platypus.instanceCounter++;
        System.debug('Instance Counter: ' + Platypus.instanceCounter);
    }
    
    public static Integer showInstanceCounter(){
        return Platypus.instanceCounter;
    }
}