require 'pry'

class Transfer
    attr_reader :sender, :receiver, :amount
    attr_accessor :status

    def initialize(sender, receiver, amount = 50)
      @sender = sender
      @receiver = receiver
      @status = "pending"
      @amount = amount
    end

    def valid?
      self.sender.valid? && self.receiver.valid?
    end

    def execute_transaction
     if valid? && sender.balance > amount && self.status == "pending"
       sender.balance -= amount
       receiver.balance += amount
       self.status = "complete"
     else
      reject_transfer
     end
    end

    def reverse_transfer
      if valid? && sender.balance > amount && self.status == "complete"
        sender.balance += amount
        receiver.balance -= amount
        self.status = "reversed"
      else
        reject_transfer
      end
    end

    def reject_transfer
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end

end


#1. build a `BankAccount` class where one instance of the class can transfer money to another instance through a `Transfer` class.
#2. The `Transfer` class acts as a space for a transaction between two instances of the bank account class. 
#   Think of it this way: you can't just transfer money to another account without the bank running checks first. 
#   `Transfer` instances will do all of this, as well as check the validity of the accounts before the transaction occurs. 
#3. `Transfer` instances should be able to reject a transfer if the accounts aren't valid or if the sender doesn't have the money.
#4.  Transfers start out in a "pending" status. They can be executed and go to a "complete" state. 
#    They can also go to a "rejected" status. 
# -  A completed transfer can also be reversed and go into a "reversed" status.