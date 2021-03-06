# coding: utf-8
require "test/unit"
require_relative "../wordcut/edge_builder.rb"
require_relative "../wordcut/dag.rb"
require_relative "../wordcut/edge.rb"
require_relative "../wordcut/pointer.rb"
require_relative "../wordcut/dict.rb"
require_relative "../wordcut/space_slicer.rb"

include Wordcut

class UpdateDictDag < Array
  include EdgeBuilder
  include DictDagUpdater
end

class UpdateUnkDag < Array
  include UnkDagUpdater
end

class UpdateSpaceDag < Array
  include SpaceDagUpdater
end

class BasicUpdateDag < Array
  include EdgeBuilder
  include BasicDagUpdater
end

class TestDict < Array
  include DictInfo
  include DictSeeker
end

class TestMyDag < Test::Unit::TestCase
  def setup
    @dict = TestDict.new ["กา", "ขา", "ขาม", "มา"].map{|w| WordItem.new(w)}
    @false_slicer = Object.extend(Module.new do
                                    def final
                                      false
                                    end
                                  end)
  end
  
  def test_update_by_dict
    dag = UpdateDictDag.new
    dag << Edge.new
    dag << nil
    final_pointers = [Pointer.new(0, 1, 1, 1, @dict, true)]
    left = dag.update_by_dict(1, final_pointers)
    assert_equal(1, left)
    assert_equal(0, dag[1].s)
    assert_equal(1, dag[1].chunk)
  end

  def test_update_by_unk
    dag = UpdateUnkDag.new
    dag << Edge.new
    dag << nil
    left = dag.update_by_unk(1, 0)
    assert_equal(0, left)
    assert_equal(0, dag[1].s)
    assert_equal(1, dag[1].unk)
  end

  def test_update_by_space
    dag = UpdateSpaceDag.new
    dag << Edge.new
    dag << nil
    slicer = SpaceSlicer.new(0)
    slicer.transit(" ", nil)
    left = dag.update_by_space(1, slicer)
    assert_equal(1, left)
    assert_equal(0, dag[1].s)
    assert_equal(1, dag[1].chunk)
    assert_equal(0, dag[1].unk)
    assert_equal(:SPACE, dag[1].etype)
  end

  
  def test_basic_update
    dag = BasicUpdateDag.new
    dag << Edge.new
    dag << nil
    left = dag.update(1, 0, [], @false_slicer)
    assert_equal(0, left)
    assert_equal(:UNK, dag[1].etype)
  end

  def test_basic_update_with_pointer
    dag = BasicUpdateDag.new
    dag << Edge.new
    dag << nil
    final_pointers = [Pointer.new(0, 1, 1, 1, @dict, true)]
    left = dag.update(1, 0, final_pointers, @false_slicer)
    assert_equal(1, left)
    assert_equal(:DICT, dag[1].etype)
  end

  def test_basic_update_with_space
    dag = BasicUpdateDag.new
    dag << Edge.new
    dag << nil
    slicer = SpaceSlicer.new(0)
    slicer.transit(" ", nil)
    left = dag.update(1, 0, [], slicer)
    assert_equal(1, left)
    assert_equal(:SPACE, dag[1].etype)
  end

  
  def test_build_dag
    dag = BasicDag.build(@dict, "ขามกา")
    assert_equal(6, dag.length)
    assert_equal(0, dag[3].s)
    assert_equal(3, dag[5].s)
  end
end

class ToTokenDag < Array
  include DagToToken
end

class TestDagConverter < Test::Unit::TestCase
  def test_basic
    dag = ToTokenDag.new
    dag << Edge.new          #0
    dag << Edge.new(:s => 0) #1
    dag << Edge.new(:s => 0) #2
    dag << Edge.new(:s => 0) #3
    dag << Edge.new(:s => 3) #4
    dag << Edge.new(:s => 3) #5
    tokens = dag.tokens("ขามกา")
    assert_equal(["ขาม", "กา"], tokens)
  end
end
