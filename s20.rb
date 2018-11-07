gem 'cancancan'
bundle

 rails g cancan:ability

models ability.rb
    user ||= User.new
    can :destroy, Post, user_id: user.id

para probar lo anterios realizamos lo siguiente en rails c
user = User.first
ability = Ability.new(user)
ability.can?(:create, Post)
ability.can?(:destroy, Post)
ability.can?(:destroy, Post.new(user: user))

pra mas informacion 
https://github.com/CanCanCommunity/cancancan/wiki

modificamos la vista de post index
       <td>
          <% if can? :destroy, post %>
						<%= link_to 'Eliminar', post, method: :delete, data: { confirm: 'Estás seguro que deseas eliminar el Post?' }, class: 'btn btn-sm btn-danger' %>
					<% end %>
			</td>

bloquear los botones si no tienes permisos
def destroy
 authorize! :destroy, @post
 @post.destroy
end
 para no agregar el autorize en cada method es mejor utilizar 

authorize_resource
 despues del before_action

 ojo que hay que tener en cuenta que se debe hacer mas completo el ability xq te puede quitar todos los permisos.

 add al ability
  can :read, Post

podemos hacer load_resource para evitar hacer el before_action todo en uns linea
load_and_authorize_resource


modificar el ability
if user.admin?
        can :manage, :all
    else
        can :read, Post
        can :destroy, Post, user_id: user.id
    end

rails g migration addRoleToUser role:integer
rake db:migrate


en el modelo de user.rb
enum role:[:admin, :visit]


ejemplo de ability
 class Ability
 include CanCan::Ability
 def initialize(user)
 user ||= User.new
 if user.admin?
 can :manage, :all
 else
 can :read, :all
 end
 end
end