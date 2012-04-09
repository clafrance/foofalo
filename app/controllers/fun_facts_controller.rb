class FunFactsController < ApplicationController
  before_filter :signed_in_user 
  before_filter :admin_user,     :only => [:create, :new, :edit, :update, :destroy]
  
  def new
    @fun_fact = FunFact.new
    @focus ="autofocus"
  end
  
  def create
    @fun_fact = current_user.fun_facts.build(params[:fun_fact])
    @fun_fact.author = current_user.username
    if @fun_fact.save
      redirect_to @fun_fact, :success => "Fun fact has been created."
    else
      render 'new'
    end
  end

  def show
    @fun_fact = FunFact.find(params[:id])
    if @fun_fact.status == 1
      @display_status = "It hasn't been published." 
    else
      @display_status = "It has been published."
    end
  end

  def index
    @fun_facts = FunFact.find(:all)
  end
  
  def edit
    @fun_fact = FunFact.find(params[:id])
  end
  
  def update
    @fun_fact = FunFact.find(params[:id])
    if @fun_fact.update_attributes(params[:fun_fact])
      flash[:success] = "Fun fact has been Updated"
      redirect_to @fun_fact
    else
      render 'edit'
    end
  end
  
  def destroy
    fun_fact = FunFact.find(params[:id])
    fun_fact.destroy
    flash[:success] = "Fun fact #{fun_fact.name} has been deleted."
    redirect_to fun_facts_path
  end
end
