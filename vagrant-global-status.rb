# -*- coding: utf-8 -*-

class Vagrant

  attr_accessor :machines

  def initialize()
    @path = ENV['HOME'] + "/.vagrant.d/data/machine-index/index"
    @machines = Array.new()
  end

  def get_machines_status()

    file = File.open(@path)
    text = file.read
    file.close()

    JSON::parse(text)["machines"].each do |machine|
      @machines.push(machine[0].slice(0...7) + " " + sprintf("%-10s", machine[1]["name"].slice(0...10)) + " " + " " + sprintf("%-10s", machine[1]["provider"].slice(0...10)) + " " + sprintf("%-10s", machine[1]["state"].slice(0...10)) + " " + machine[1]["local_data_path"])
    end
  end

end

def main
  vagrant = Vagrant.new()
  vagrant.get_machines_status()

  return vagrant.machines
end

main
