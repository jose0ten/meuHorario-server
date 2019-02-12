module TimeslotModule

  def self.toTimeslotArray(times)
    newObj = {}
    i = 0
    times.split(' ').each do |time|
      regex = /(([1-9]*)(T|M|N)([1-9]*))/
      myTime = time.scan(regex)

      unless myTime.empty?

        dias = myTime[0][1].to_s
        turno = myTime[0][2]
        horas = myTime[0][3].to_s

        dias.each_char do |element|
          newObj[i] = {
            day: element.to_i - 2,
            startingHour: convertToHour(turno, horas[0]),
            endingHour: convertToHour(turno, horas[horas.length - 1]) + 1,
          }
          i += 1
        end

      end

    end
    return newObj
  end

  private

  def self.convertToHour(time, hour)
    cHour = hour.to_i
    if (time === 'M')
      return cHour + 6
    end
    if (time === 'T')
      return cHour + 12
    end
    if (time === 'N')
      return cHour + 18
    end
    return cHour
  end

end
