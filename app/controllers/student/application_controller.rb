
class Student::ApplicationController < ApplicationController
  before_action :authenticate_user!

  layout 'student/application'
end  
