# Enter your input and output device names here
source=bluez_source.98_09_CF_F3_12_0F.headset_head_unit
sink=bluez_sink.98_09_CF_F3_12_0F.headset_head_unit

# Module names
sharednull=shared-null-sink
sharedsink=shared-sink
sharedsource=shared-source

# Cleanup devices left over from prior runs
{
  pactl list short modules | grep $sharednull | cut -f1 | xargs -L1 pactl unload-module
  pactl list short modules | grep $sharedsink | cut -f1 | xargs -L1 pactl unload-module
  pactl list short modules | grep $sharedsource | cut -f1 | xargs -L1 pactl unload-module
} &> /dev/null

# Check if both input and out devices exist
if [[ $(pactl list sources | grep -e $source | wc -c) == 0 ]]; then
  echo "Input device '$source' not connected"
  exit 1
fi
if [[ $(pactl list sinks | grep -e $sink | wc -c) == 0  ]]; then
  echo "Output device '$sink' not connected"
  exit 1
fi

{

    # Create the null sink and loopback the input source into it
    pactl load-module module-null-sink sink_name=$sharednull
    pactl load-module module-loopback source=$source sink=$sharednull

    # Create a virtual sink that splits all audio towards both the microphone sink and the output sink
    # Pipe any app you want to share with your input to this sink
    pactl load-module module-combine-sink slaves=$sharednull,$sink sink_name=$sharedsink sink_properties="device.description=Shared-Sink"

    # Create a virtual source monitoring the microphone sink to use within any app where you want audio input
    pactl load-module module-remap-source master=$sharednull.monitor source_name=$sharedsource  source_properties="device.description=Shared-Source"

} &> /dev/null

echo 'Finished setting up Shared-Sink and Shared-Source'
echo
echo 'To setup your applications:'
echo '  First, switch the recording application to the Shared-Source'
echo '  And then set the playback application you want to share to Shared-Sink'
echo
echo 'Unfortunately, you might need to restart the recording app if you ever disconnect your mic.'
echo 'Classic Pulseaudio design issue!'
