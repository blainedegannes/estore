require 'spec_helper'

describe User do
  
    before(:each) do
      @attr = { :f_name => "Blaine", 
                :l_name => "Degannes", 
                :email => "blaine@entreelife.com",
                :password => "foobared",
                :password_confirmation => "foobared" }
  end

    it "should create a new instance given valid attributes" do
      User.create!(@attr)
  end

    it "should require a first name" do
      no_f_name_user = User.new(@attr.merge(:f_name => ""))
      no_f_name_user.should_not be_valid
  end
    
    it "should require a last name" do
      no_l_name_user = User.new(@attr.merge(:l_name => ""))
      no_l_name_user.should_not be_valid
  end
  
    it "should require a email" do
      no_email_user = User.new(@attr.merge(:email => ""))
      no_email_user.should_not be_valid
  end
  
    it "should reject first names that are too long" do
        long_f_name = "a" * 16
        long_f_name_user = User.new(@attr.merge(:f_name => long_f_name))
        long_f_name_user.should_not be_valid
  end
  
    it "should reject last names that are too long" do
        long_l_name = "a" * 26
        long_l_name_user = User.new(@attr.merge(:l_name => long_l_name))
        long_l_name_user.should_not be_valid
  end
  
    it "should reject first names that are too short" do
        short_f_name = "a" * 1
        short_f_name_user = User.new(@attr.merge(:f_name => short_f_name))
        short_f_name_user.should_not be_valid
  end
  
    it "should reject last names that are too short" do
        short_l_name = "a" * 2
        short_l_name_user = User.new(@attr.merge(:l_name => short_l_name))
        short_l_name_user.should_not be_valid
  end
    
    it "should accept valid email addresses" do
        addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        addresses.each do |address|
          valid_email_user = User.new(@attr.merge(:email => address))
          valid_email_user.should be_valid
    end
  end

      it "should reject invalid email addresses" do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
        addresses.each do |address|
          invalid_email_user = User.new(@attr.merge(:email => address))
          invalid_email_user.should_not be_valid
    end
  end
     
     it "should reject duplicate email addresses" do
         # Put a user with given email address into the database.
         User.create!(@attr)
         user_with_duplicate_email = User.new(@attr)
         user_with_duplicate_email.should_not be_valid
    end
    
     it "should reject email addresses identical up to case" do
         upcased_email = @attr[:email].upcase
         User.create!(@attr.merge(:email => upcased_email))
         user_with_duplicate_email = User.new(@attr)
         user_with_duplicate_email.should_not be_valid
    end
    
    describe "password validations" do

        it "should require a password" do
          User.new(@attr.merge(:password => "", :password_confirmation => "")).
            should_not be_valid
        end

        it "should require a matching password confirmation" do
          User.new(@attr.merge(:password_confirmation => "invalid")).
            should_not be_valid
        end

        it "should reject short passwords" do
          short_password = "a" * 7
          hash = @attr.merge(:password => short_password, :password_confirmation => short_password)
          User.new(hash).should_not be_valid
        end

        it "should reject long passwords" do
          long_password = "a" * 41
          hash = @attr.merge(:password => long_password, :password_confirmation => long_password)
          User.new(hash).should_not be_valid
        end
      end
      
    describe "password encryption" do

       before(:each) do
          @user = User.create!(@attr)
       end

       it "should have an encrypted password attribute" do
          @user.should respond_to(:encrypted_password)
       end
       
       it "should set the encrypted password" do
             @user.encrypted_password.should_not be_blank
       end
       
       describe "has_password? method" do

       it "should be true if the passwords match" do
           @user.has_password?(@attr[:password]).should be_true
        end    

       it "should be false if the passwords don't match" do
           @user.has_password?("invalid").should be_false
        end 
      end
      
      describe "authenticate method" do

      it "should return nil on email/password mismatch" do
          wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
          wrong_password_user.should be_nil
      end

       it "should return nil for an email address with no user" do
          nonexistent_user = User.authenticate("bar@foo.com", @attr[:password])
          nonexistent_user.should be_nil
       end

       it "should return the user on email/password match" do
           matching_user = User.authenticate(@attr[:email], @attr[:password])
           matching_user.should == @user
       end
     end
  end
end  

