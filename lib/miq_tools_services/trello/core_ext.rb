require 'trello'

module Trello
  class Organization
    def board(name)
      boards.index_by(&:name)[name]
    end
  end

  class Board
    def list(name)
      lists.index_by(&:name)[name]
    end
  end

  class List
    def card(name)
      cards.index_by(&:name)[name]
    end

    def add_card(card_name)
      Trello::Card.create(:name => card_name, :list_id => self.id, :pos => "bottom")
    end
  end

  class Card
    def checklist(name)
      checklists.index_by(&:name)[name]
    end

    # Create and return a new checklist for this card
    # create_new_checklist should return the new checklist object and not the post body from the API response
    def create_new_checklist_with_returning_object(checklist_name)
      create_new_checklist_without_returning_object(checklist_name)
      checklist(checklist_name)
    end
    alias_method_chain :create_new_checklist, :returning_object

    def create_checklist(name, *items)
      create_new_checklist(name).tap do |checklist|
        checklist.add_items(items)
      end
    end

    def remove_all_checklists
      checklists.each(&:delete)
    end

    def update_checklists(new_checklists)
      previous = checklists.each_with_object({}) do |checklist, h|
        h[checklist.name] = checklist.items.collect(&:name)
      end

      deleted_checklists = previous.keys - new_checklists.keys
      added_checklists   = new_checklists.keys - previous.keys
      updated_checklists = new_checklists.keys & previous.keys

      deleted_checklists.each do |name|
        logger.debug("Deleting checklist #{name}")
        delete_checklist(name)
      end

      added_checklists.each do |name|
        logger.debug("Creating checklist #{name}: #{new_checklists[name].length} items added")
        create_checklist(name, new_checklists[name])
      end

      updated_checklists.each do |name|
        deleted = previous[name] - new_checklists[name]
        added   = new_checklists[name] - previous[name]
        logger.debug("Updating checklist #{name}: #{deleted.length} items deleted, #{added.length} items added")

        checklist = checklist(name)
        checklist.remove_items(deleted)
        checklist.add_items(added)
      end
    end
  end

  class Checklist
    # Adds an array of strings as unchecked items
    def add_items(*checklist_items)
      checklist_items.flatten.each { |i| puts "     Adding item: #{i}";  add_item(i) }
    end

    # Removes several items by name
    def remove_items(*checklist_items)
      items_by_name = items.index_by(&:name)
      checklist_items.flatten.each do |name|
        delete_checklist_item(items_by_name[name].id)
      end
    end

    def checked_items
      items.select { |i| i.state == "complete" }
    end

    def unchecked_items
      items.select { |i| i.state != "complete" }
    end
  end

  class Item
    def bugzilla_id
      MiqToolsServices::Bugzilla.parse_id(name)
    end
  end
end
