# coding: utf-8

module ApplicationHelper

  def title
    base_title = "Perechin.net"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end

  def month(month_number)
    %w'січня лютого березня'[month_number - 1]
  end


end
