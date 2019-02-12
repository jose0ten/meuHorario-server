module WorkloadModule

  def self.toWorkloadArray(work)
    newObj = {}

    regex = /(([0-9]*)h\saula\s([0-9])h\slab\.)/
    myWork = work.scan(regex)

    unless myWork.empty?

      lab = myWork[0][2].to_i

    else

      regex = /(([0-9]*)h)/
      myWork = work.scan(regex)

      lab = 0

    end

    classroom = myWork[0][1].to_i

    newObj = {
      classroom: classroom,
      lab: lab,
      total: classroom + lab,
    }

    return newObj
  end

end
