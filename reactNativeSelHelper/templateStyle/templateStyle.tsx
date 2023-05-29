import { StatusBar } from 'expo-status-bar';
import {StyleSheet, View, Text} from 'react-native';

export default function App() {
    return (
        <View style={styles.container}>
            <View>
                <Text>Hello World</Text>
            </View>
            <StatusBar style="auto" />
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: "red",
        alignItems: 'center',
    },
});
